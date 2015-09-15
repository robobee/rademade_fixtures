require_relative '../lib/user_factory'

describe UserFactory do

  describe "implements AbstractFactory interface" do
    describe "implements create()" do

      let(:factory) { UserFactory.new }
      let(:object) { factory.create}

      it "returns AbstractProduct type" do
        expect(object).to respond_to(:get)
        expect(object).to respond_to(:set)
        expect(object).to respond_to(:save)
      end

      it "returns User" do
        expect(object).to be_instance_of User
      end

    end
  end

end
