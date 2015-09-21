module RademadeFixtures
  class UnknownModelError < StandardError
  end

  class Loader

    attr_reader :fixtures_folder

    def initialize(fixtures_folder)
      @fixtures_folder = fixtures_folder
    end

    def load_fixtures
      files.each do |file|
        model_alias = get_model_alias(file)
        factory = choose_factory(model_alias)
        representations = process_file(file)
        representations.each do |repr|
          create_fixture(repr, factory)
        end
      end
    end

    private

    def choose_factory(model_alias)
      if model_alias == 'user'
        factory = UserFactory.new
      elsif model_alias == 'post'
        factory = PostFactory.new
      else
        raise UnknownModelError
      end
    end

    def create_fixture(repr, factory)
      object = factory.create_from_hash(repr)
      object.save
    end

    def files
      raise NotImplementedError
    end

    def process_file(file)
      raise NotImplementedError
    end

    def get_model_alias(file)
      raise NotImplementedError
    end

  end
end
