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

  def self.get_connection(config)
    @instance ||= Connection.new(dbname: config[:dbname])
    private_class_method :new
    @instance
  end

  def self.instance
    @instance
  end

end
