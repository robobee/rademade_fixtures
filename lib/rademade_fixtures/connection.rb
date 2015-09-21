require 'pg'

module RademadeFixtures
  class Connection

    def initialize(config)
      begin
        @connection = PG.connect(config)
      rescue PG::ConnectionBad => e
        puts 'DB Connection Error'
        puts e.message
        exit
      end
      @connection.type_map_for_results = PG::BasicTypeMapForResults.new(@connection)
    end

    def exec_params(sql, params)
      @connection.exec_params(sql, params)
    end

    def exec_sql(sql)
      @connection.exec(sql)
    end

    def self.connection(config)
      @instance ||= Connection.new(config)
      private_class_method :new
      @instance
    end

    def self.instance
      @instance
    end

  end
end
