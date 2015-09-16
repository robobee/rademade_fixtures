require_relative 'connection.rb'

class ActiveRecord

  def initialize(connection = Connection.instance)
    @connection = connection
    @proxy = Hash.new
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
    columns = attributes.map(&:to_s).join(", ")
    values = (1..attributes.count).map { |i| "$#{i}" }.join(", ")
    params = attributes.map { |a| @proxy[a] }
    sql = "INSERT INTO #{table_name} (#{columns}) VALUES (#{values})"
    @connection.exec_params(sql, params)
  end

  def table_name
    raise NotImplementedError
  end

  def attributes
    raise NotImplementedError
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
    self.attributes.each do |attribute|
      object.set(attribute, result[0][attribute.to_s])
    end
    object
  end

end
