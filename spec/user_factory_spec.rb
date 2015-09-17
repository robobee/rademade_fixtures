module RademadeFixtures
  describe UserFactory do

    describe "implements AbstractFactory interface" do
      describe "implements create()" do

        let(:factory) { UserFactory.new }
        let(:object) { factory.create}
        let(:object_from_hash) do
          factory.create_from_hash id: 2, name: 'Vasiliy', last_name: 'Pupkin', age: 50
        end

        it "returns AbstractProduct type" do
          expect(object).to respond_to(:get)
          expect(object).to respond_to(:set)
          expect(object).to respond_to(:save)
          expect(object.class).to respond_to(:find)
        end

        it "returns User" do
          expect(object).to be_instance_of User
        end

        it "can create User from hash" do
          expect(object_from_hash).to be_instance_of User
          expect(object_from_hash.get(:id)).to eq 2
          expect(object_from_hash.get(:name)).to eq 'Vasiliy'
          expect(object_from_hash.get(:last_name)).to eq 'Pupkin'
          expect(object_from_hash.get(:age)).to eq 50
        end

      end
    end

  end
end
