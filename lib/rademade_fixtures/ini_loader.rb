module RademadeFixtures
  class IniLoader < Loader

    private

    def files
      glob = File.join(fixtures_folder, "*.ini")
      Dir[glob]
    end

    def process_file(file)
      result = Hash.new
      File.open(file) do |f|
        f.each do |line|
          data = line.chomp.match /\Adata\[(.*)\]\[(.*)\]=\"(.*)\"\Z/
          whole_string, model_alias, attribute, value = data.to_a
          if result[model_alias]
            result[model_alias][attribute] = value
          else
            result[model_alias] = Hash.new
            result[model_alias][attribute] = value
          end
        end
      end
      result.values
    end

    def get_model_alias(file)
      File.basename(file, '.ini')
    end

  end
end
