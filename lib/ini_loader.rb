class IniLoader < Loader

  private

  def get_files
    glob = fixtures_folder << "/*.ini"
    Dir[glob]
  end

  def process_file(file)
    result = Hash.new
    File.open(file) do |f|
      f.each do |line|
        data = line.chomp.match /\Adata\[(.*)\]\[(.*)\]=\"(.*)\"\Z/
        model_alias = data[1]
        attribute = data[2]
        value = data[3]
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
