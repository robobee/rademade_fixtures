describe Loader do

  let(:loader) { Loader.new('.') }

  it "forces subclasses to implement #get_files" do
    expect { loader.send(:get_files) }.to raise_error(NotImplementedError)
  end

  it "forces subclasses to implement #process_file" do
    expect { loader.send(:process_file, nil) }.to raise_error(NotImplementedError)
  end

  it "forces subclasses to implement #get_model_alias" do
    expect { loader.send(:get_model_alias, nil) }.to raise_error(NotImplementedError)
  end

end
