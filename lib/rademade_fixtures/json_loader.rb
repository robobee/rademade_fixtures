require 'json'

module RademadeFixtures
  class JsonLoader < Loader

    private

    def get_files
      glob = File.join(fixtures_folder, "*.json")
      Dir[glob]
    end

    def process_file(file)
      JSON.parse(File.read(file))
    end

    def get_model_alias(file)
      File.basename(file, '.json')
    end

  end
end
