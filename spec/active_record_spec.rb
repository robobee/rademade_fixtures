require_relative '../lib/active_record'

describe ActiveRecord do

  describe "it is an abstract class, requires subclasses to implement" do

    before do
      @model = ActiveRecord.new
    end

    it "forces subclasses to implement #model_alias" do
      expect { @model.model_alias }.to raise_error(NotImplementedError)
    end

    it "forces subclasses to implement #attributes" do
      expect { @model.attributes }.to raise_error(NotImplementedError)
    end

  end

end
