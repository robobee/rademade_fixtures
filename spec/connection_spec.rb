require_relative '../lib/connection.rb'

describe Connection do

  it "has a singleton object instance" do
    expect(Connection).to respond_to(:instance)
  end

  it "can not be instantiated" do
    expect { Connection.new }.to raise_error(NoMethodError)
  end

  describe "can execute sql" do
    it "responds to :exec_sql" do
      expect(Connection.instance).to respond_to(:exec_params)
    end

    it "returns PG::Result" do
      expect(Connection.instance.exec_sql('')).to be_instance_of(PG::Result)
    end

    it "creates and reads post via SQL" do
      Connection.instance.exec_sql("INSERT INTO posts (id, name, text) VALUES (1, 'Hello', 'World')")
      res = Connection.instance.exec_sql("SELECT * FROM posts")
      expect(res[0]['id']).to eq 1
      expect(res[0]['name']).to eq 'Hello'
      expect(res[0]['text']).to eq 'World'
    end
  end

  describe "can execute sql with interpolated params" do
    it "responds to :exec_params" do
      expect(Connection.instance).to respond_to(:exec_params)
    end

    it "returns PG::Result" do
      expect(Connection.instance.exec_params('', [])).to be_instance_of(PG::Result)
    end

    it "creates and reads post via SQL" do
      Connection.instance.exec_params("INSERT INTO posts (id, name, text) VALUES ($1, $2, $3)",
          [1, 'Hello', 'World'])
      res = Connection.instance.exec_sql("SELECT * FROM posts")
      expect(res[0]['id']).to eq 1
      expect(res[0]['name']).to eq 'Hello'
      expect(res[0]['text']).to eq 'World'
    end
  end

end
