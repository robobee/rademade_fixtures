module RademadeFixtures
  describe IniLoader do

    let(:loader) { IniLoader.new(Dir.pwd << "/spec/fixtures") }

    let(:user_three) { User.find(3) }
    let(:user_four) { User.find(4) }
    let(:post_three) { Post.find(3) }
    let(:post_four) { Post.find(4) }

    it "correctly loads fixtures into database" do
      loader.load_fixtures

      expect(Connection.instance.exec_sql("SELECT * FROM users").cmd_tuples).to eq 2
      expect(Connection.instance.exec_sql("SELECT * FROM posts").cmd_tuples).to eq 2

      expect(user_three.get(:id)).to eq 3
      expect(user_three.get(:name)).to eq "Michael"
      expect(user_three.get(:last_name)).to eq "Jackson"
      expect(user_three.get(:age)).to eq 41

      expect(user_four.get(:id)).to eq 4
      expect(user_four.get(:name)).to eq "Tina"
      expect(user_four.get(:last_name)).to eq "Turner"
      expect(user_four.get(:age)).to eq 55

      expect(post_three.get(:id)).to eq 3
      expect(post_three.get(:name)).to eq "Motivation"
      expect(post_three.get(:text)).to eq "Just do it"

      expect(post_four.get(:id)).to eq 4
      expect(post_four.get(:name)).to eq "Rails Tutorial"
      expect(post_four.get(:text)).to eq "Just scaffold something"
    end

  end
end
