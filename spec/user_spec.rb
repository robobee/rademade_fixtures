require_relative '../lib/user.rb'

describe User do

  describe "implements ActiveRecord interface" do
    let(:user) { User.new }

    it "implements #get" do
      expect(user).to respond_to(:get)
    end

    it "implements #set" do
      expect(user).to respond_to(:set)
    end

    it "implements #save" do
      expect(user).to respond_to(:save)
    end

    it "implements self.table_name" do
      expect(user.class).to respond_to(:table_name)
      expect { user.class.table_name }.not_to raise_error
    end

    it "implements self.attributes" do
      expect(user.class).to respond_to(:attributes)
      expect { user.class.attributes }.not_to raise_error
    end
  end

  describe "setting and getting attributes" do

    let(:user) { User.new }

    context "with valid attributes" do

      it "sets attribute to a given value" do
        user.set(:id, 1)
        user.set(:name, 'John')
        expect(user.get(:id)).to eq 1
        expect(user.get(:name)).to eq 'John'
      end

    end

    context "with invalid attributes" do
      it "raises an argument error on get" do
        expect { user.get(:invalid_attribute) }.to raise_error(ArgumentError)
      end

      it "raises an argument error on set" do
        expect { user.set(:invalid_attribute, 'hello') }.to raise_error(ArgumentError)
      end
    end
  end

  describe "saving an object" do

    context "when not persisted" do

      it "calls connection #exec_params with correct sql" do
        @connection = double("connection")
        allow(@connection).to receive(:exec_params) { true }
        @user = User.new(connection: @connection)

        @user.set(:id, 1)
        @user.set(:name, 'John')
        @user.set(:last_name, 'Doe')
        @user.set(:age, 35)

        expect(@connection).to receive(:exec_params)
          .with("INSERT INTO users (id, name, last_name, age) VALUES ($1, $2, $3, $4)",
            [1, "John", "Doe", 35])
        @user.save
      end

      it "saves user to database" do
        @user = User.new
        @user.set(:id, 2)
        @user.set(:name, 'John')
        @user.set(:last_name, 'Doe')
        @user.set(:age, 35)
        @user.save

        found = User.find(2)
        expect(found.get(:id)).to eq @user.get(:id)
        expect(found.get(:name)).to eq @user.get(:name)
        expect(found.get(:last_name)).to eq @user.get(:last_name)
        expect(found.get(:age)).to eq @user.get(:age)
      end

    end

    context "when persisted" do

      before(:each) do
        Connection.instance.exec_sql("INSERT INTO users (id, name, last_name, age) VALUES (1, 'John', 'Doe', 35)")
      end

      it "updates user in the database" do
        user = User.find(1)
        user.set(:name, "Vasiliy")
        user.save
        user = User.find(1)
        expect(user.get(:name)).to eq("Vasiliy")
      end

    end

  end

  describe "User.find, finding an object" do
    context "when object is present in database" do
      before(:each) do
        Connection.instance.exec_sql("INSERT INTO users (id, name, last_name, age) VALUES (1, 'John', 'Doe', 35)")
      end

      it "retrieves object from database" do
        result = User.find(1)
        expect(result).to be_instance_of User
        expect(result.get(:id)).to eq(1)
        expect(result.get(:name)).to eq('John')
        expect(result.get(:last_name)).to eq('Doe')
        expect(result.get(:age)).to eq(35)
      end
    end

    context "when there is no such object" do
      it "returns nil" do
        result = User.find(2)
        expect(result).to be nil
      end
    end
  end

end
