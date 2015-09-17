module RademadeFixtures
  describe ActiveRecord do

    describe "it is an abstract class" do

      before(:all) do
        @model = ActiveRecord.new(attributes: [], table_name: "")
      end

      it "forces subclasses to implement self.table_name" do
        expect { @model.class.table_name }.to raise_error(NotImplementedError)
      end

      it "forces subclasses to implement self.attributes" do
        expect { @model.class.attributes }.to raise_error(NotImplementedError)
      end

    end

  end
end
