require_relative '../lib/connection.rb'

describe Connection do

  it "has a singleton object instance" do
    expect(Connection).to respond_to(:instance)
  end

  it "can not be instantiated" do
    expect { Connection.new }.to raise_error(NoMethodError)
  end

  it "can execute sql" do
    expect(Connection.instance).to respond_to(:exec_params)
    expect(Connection.instance.exec_params('', [])).to be_instance_of(PG::Result)
  end

end
