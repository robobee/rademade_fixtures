module RademadeFixtures
  class ActiveRecord

    attr_accessor :persisted
    attr_accessor :attributes
    attr_accessor :table_name

    def initialize(config = {})
      @connection = config[:connection] || Connection.instance
      @attributes = config[:attributes] || self.class.attributes
      @table_name = config[:table_name] || self.class.table_name
      @proxy = Hash.new
      @persisted = false
    end

    def get(attribute)
      unless attributes.include?(attribute)
        raise ArgumentError
      end
      @proxy[attribute]
    end

    def set(attribute, value)
      unless attributes.include?(attribute)
        raise ArgumentError
      end
      @proxy[attribute] = value
    end

    def save
      if persisted
        columns = attributes.map(&:to_s)
        placeholders = (1..attributes.count).map { |i| "$#{i}" }
        zipped = columns.zip(placeholders).map { |pair| pair.join(" = ") }.join(", ")
        params = attributes.map { |a| @proxy[a] }
        sql = "UPDATE #{table_name} SET #{zipped} WHERE id = #{@proxy[:id]}"
      else
        columns = attributes.map(&:to_s).join(", ")
        placeholders = (1..attributes.count).map { |i| "$#{i}" }.join(", ")
        params = attributes.map { |a| @proxy[a] }
        sql = "INSERT INTO #{table_name} (#{columns}) VALUES (#{placeholders})"
      end
      @connection.exec_params(sql, params)
    end

    def self.attributes
      raise NotImplementedError
    end

    def self.table_name
      raise NotImplementedError
    end

    def self.find(id)
      sql = "SELECT * FROM #{table_name} WHERE id = $1"
      result = Connection.instance.exec_params(sql, [id])
      return nil if result.cmd_tuples == 0

      object = self.new
      object.persisted = true
      self.attributes.each do |attribute|
        object.set(attribute, result[0][attribute.to_s])
      end
      object
    end

  end
end
