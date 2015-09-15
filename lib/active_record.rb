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
    sql = "INSERT INTO #{model_alias} (#{columns}) VALUES (#{values})"
    @connection.exec_params(sql, params)
  end

  def model_alias
    raise NotImplementedError
  end

  def attributes
    raise NotImplementedError
  end

end
