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

    it "implements #table_name" do
      expect(post).to respond_to(:table_name)
      expect { post.table_name }.not_to raise_error
    end

    it "implements #attributes" do
      expect(post).to respond_to(:attributes)
      expect { post.attributes }.not_to raise_error
    end

    it "implements self.table_name" do
      expect(post.class).to respond_to(:table_name)
      expect { post.class.table_name }.not_to raise_error
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

    before(:each) do
      @connection = double("connection")
      allow(@connection).to receive(:exec_params) { true }
      @user = Post.new(@connection)
    end

    it "calls connection #exec_params with correct sql" do
      @user.set(:id, 2)
      @user.set(:name, 'Hello World')
      @user.set(:text, "What's up everybody?")
      expect(@connection).to receive(:exec_params)
        .with("INSERT INTO posts (id, name, text) VALUES ($1, $2, $3)",
          [2, "Hello World", "What's up everybody?"])
      @user.save
    end

  end

  describe "Post.find" do
    it "calls connection #exec_params with correct sql" do
      expect(Connection.instance).to receive(:exec_params)
        .with("SELECT * FROM posts WHERE id = $1", [2])

      Post.find(2)
    end
  end

end
