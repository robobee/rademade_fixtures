require_relative '../lib/user.rb'
require 'pry'

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

    it "implements #model_alias" do
      expect(user).to respond_to(:model_alias)
      expect { user.model_alias }.not_to raise_error
    end

    it "implements #attributes" do
      expect(user).to respond_to(:attributes)
      expect { user.attributes }.not_to raise_error
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

    before(:each) do
      @connection = double("connection")
      allow(@connection).to receive(:exec_params) { true }
      @user = User.new(@connection)
    end

    it "calls connection #exec_params with correct sql" do
      @user.set(:id, 1)
      @user.set(:name, 'John')
      @user.set(:last_name, 'Doe')
      @user.set(:age, 35)
      expect(@connection).to receive(:exec_params)
        .with("INSERT INTO user (id, name, last_name, age) VALUES ($1, $2, $3, $4)",
          [1, "John", "Doe", 35])
      @user.save
    end

  end

end
