require 'rademade_fixtures/version'
require 'rademade_fixtures/connection'
require 'rademade_fixtures/active_record'
require 'rademade_fixtures/post'
require 'rademade_fixtures/post_factory'
require 'rademade_fixtures/user'
require 'rademade_fixtures/user_factory'
require 'rademade_fixtures/loader'
require 'rademade_fixtures/json_loader'
require 'rademade_fixtures/ini_loader'

module RademadeFixtures

  def self.load_fixtures(config = {})
    unless config[:fixtures_folder]
      puts 'fixtures_folder is required'
      return
    end
    fixtures_folder = config[:fixtures_folder]
    Connection.get_connection(dbname: 'rademade')
    JsonLoader.new(fixtures_folder).load_fixtures
    IniLoader.new(fixtures_folder).load_fixtures
  end

end
