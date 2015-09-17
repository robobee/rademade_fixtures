module RademadeFixtures
  describe RademadeFixtures, :connection => true  do

    context "with proper config parameter" do
      before(:each) do
        RademadeFixtures.load_fixtures(fixtures_folder: Dir.pwd + "/spec/fixtures",
                                      db: { dbname: 'rademade' })
      end

      it "correctly loads fixtures into database" do
        expect(Connection.instance.exec_sql("SELECT * FROM users").cmd_tuples).to eq 4
        expect(Connection.instance.exec_sql("SELECT * FROM posts").cmd_tuples).to eq 4
      end
    end

    context "without config parameters" do
      it "does not load fixtures into database without all params" do
        RademadeFixtures.load_fixtures()
        expect(Connection.instance.exec_sql("SELECT * FROM users").cmd_tuples).to eq 0
        expect(Connection.instance.exec_sql("SELECT * FROM posts").cmd_tuples).to eq 0
      end

      it "does not load fixtures into database without db" do
        RademadeFixtures.load_fixtures(fixtures_folder: Dir.pwd + "/spec/fixtures")
        expect(Connection.instance.exec_sql("SELECT * FROM users").cmd_tuples).to eq 0
        expect(Connection.instance.exec_sql("SELECT * FROM posts").cmd_tuples).to eq 0
      end

      it "does not load fixtures into database without fixtures_folder" do
        RademadeFixtures.load_fixtures(db: { dbname: 'rademade' })
        expect(Connection.instance.exec_sql("SELECT * FROM users").cmd_tuples).to eq 0
        expect(Connection.instance.exec_sql("SELECT * FROM posts").cmd_tuples).to eq 0
      end
    end

  end
end
