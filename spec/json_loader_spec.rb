describe JsonLoader do

  let(:loader) { JsonLoader.new(Dir.pwd << "/fixtures") }

  let(:user_one) { User.find(1) }
  let(:user_two) { User.find(2) }
  let(:post_one) { Post.find(1) }
  let(:post_two) { Post.find(2) }

  it "correctly loads fixtures into database" do
    loader.load_fixtures

    expect(Connection.instance.exec_sql("SELECT * FROM users").cmd_tuples).to eq 2
    expect(Connection.instance.exec_sql("SELECT * FROM posts").cmd_tuples).to eq 2

    expect(user_one.get(:id)).to eq 1
    expect(user_one.get(:name)).to eq "John"
    expect(user_one.get(:last_name)).to eq "Doe"
    expect(user_one.get(:age)).to eq 35

    expect(user_two.get(:id)).to eq 2
    expect(user_two.get(:name)).to eq "Mary"
    expect(user_two.get(:last_name)).to eq "Brown"
    expect(user_two.get(:age)).to eq 30

    expect(post_one.get(:id)).to eq 1
    expect(post_one.get(:name)).to eq "First post"
    expect(post_one.get(:text)).to eq "Hello everyone"

    expect(post_two.get(:id)).to eq 2
    expect(post_two.get(:name)).to eq "Second post"
    expect(post_two.get(:text)).to eq "This is awesome!"
  end

end
