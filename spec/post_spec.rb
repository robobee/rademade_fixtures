require_relative '../lib/post.rb'

describe Post do

  describe "implements ActiveRecord interface" do
    let(:post) { Post.new }

    it "implements #get" do
      expect(post).to respond_to(:get)
    end

    it "implements #set" do
      expect(post).to respond_to(:set)
    end

    it "implements #save" do
      expect(post).to respond_to(:save)
    end

    it "implements self.table_name" do
      expect(post.class).to respond_to(:table_name)
      expect { post.class.table_name }.not_to raise_error
    end

    it "implements self.attributes" do
      expect(post.class).to respond_to(:attributes)
      expect { post.class.attributes }.not_to raise_error
    end

  end

  describe "setting and getting attributes" do

    let(:post) { Post.new }

    context "with valid attributes" do

      it "sets attribute to a given value" do
        post.set(:id, 1)
        post.set(:text, 'John')
        expect(post.get(:id)).to eq 1
        expect(post.get(:text)).to eq 'John'
      end

    end

    context "with invalid attributes" do
      it "raises an argument error on get" do
        expect { post.get(:last_name) }.to raise_error(ArgumentError)
      end

      it "raises an argument error on set" do
        expect { post.set(:last_name, 'hello') }.to raise_error(ArgumentError)
      end
    end
  end

  describe "saving an object" do

    context "when not persisted" do
      it "calls connection #exec_params with correct sql" do
        @connection = double("connection")
        allow(@connection).to receive(:exec_params) { true }
        @post = Post.new(connection: @connection)

        @post.set(:id, 2)
        @post.set(:name, 'Hello World')
        @post.set(:text, "What's up everybody?")

        expect(@connection).to receive(:exec_params)
          .with("INSERT INTO posts (id, name, text) VALUES ($1, $2, $3)",
            [2, "Hello World", "What's up everybody?"])
        @post.save
      end

      it "saves post to database" do
        @post = Post.new
        @post.set(:id, 2)
        @post.set(:name, 'Hello World')
        @post.set(:text, "What's up everybody?")
        @post.save

        found = Post.find(2)
        expect(found.get(:id)).to eq @post.get(:id)
        expect(found.get(:name)).to eq @post.get(:name)
        expect(found.get(:text)).to eq @post.get(:text)
      end
    end

    context "when persisted" do

      before(:each) do
        Connection.instance.exec_sql("INSERT INTO posts (id, name, text) VALUES (1, 'Hello', 'World')")
      end

      it "updates user in the database" do
        post = Post.find(1)
        post.set(:text, "Ruby")
        post.save
        post = Post.find(1)
        expect(post.get(:text)).to eq("Ruby")
      end
    end
  end

  describe "Post.find, finding an object" do

    context "when object is present in database" do
      before(:each) do
        Connection.instance.exec_sql("INSERT INTO posts (id, name, text) VALUES (1, 'Hello', 'World')")
      end

      it "retrieves object from database" do
        result = Post.find(1)
        expect(result).to be_instance_of Post
        expect(result.get(:id)).to eq(1)
        expect(result.get(:name)).to eq('Hello')
        expect(result.get(:text)).to eq('World')
      end
    end

    context "when there is no such object" do
      it "returns nil" do
        result = Post.find(2)
        expect(result).to be nil
      end
    end

  end

end
