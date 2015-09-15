require 'pg'

class Connection

  def initialize(config)
    @connection = PG.connect(dbname: config[:dbname])
  end

  def exec_params(sql, params)
    @connection.exec_params(sql, params)
  end

  @instance = Connection.new(dbname: 'todo_development')

  def self.instance
    @instance
  end

  private_class_method :new
end
