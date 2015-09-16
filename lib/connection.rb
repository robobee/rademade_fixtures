require 'pg'

class Connection

  def initialize(config)
    @connection = PG.connect(dbname: config[:dbname])
    @connection.type_map_for_results = PG::BasicTypeMapForResults.new(@connection)
  end

  def exec_params(sql, params)
    @connection.exec_params(sql, params)
  end

  def exec_sql(sql)
    @connection.exec(sql)
  end

  @instance = Connection.new(dbname: 'rademade')

  def self.instance
    @instance
  end

  private_class_method :new
end
