module RademadeFixtures
  describe PostFactory do

    describe "implements AbstractFactory interface" do
      describe "implements create()" do

        let(:factory) { PostFactory.new }
        let(:object) { factory.create }
        let(:object_from_hash) do
          factory.create_from_hash id: 1, name: 'Some name', text: 'Some text'
        end

        it "returns AbstractProduct type" do
          expect(object).to respond_to(:get)
          expect(object).to respond_to(:set)
          expect(object).to respond_to(:save)
          expect(object.class).to respond_to(:find)
        end

        it "returns Post" do
          expect(object).to be_instance_of Post
        end

        it "can create Post from hash" do
          expect(object_from_hash).to be_instance_of Post
          expect(object_from_hash.get(:id)).to eq 1
          expect(object_from_hash.get(:name)).to eq 'Some name'
          expect(object_from_hash.get(:text)).to eq 'Some text'
        end

      end
    end

  end
end
