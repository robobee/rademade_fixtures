Readme
======

Description:
------------
Fixture loader utility, packaged as a gem.

Installation instructions:
--------------------------
1. Clone this repository to local machine
2. Can run tests with "rspec sepc" **(see prerequisites and setup)**
3. Run "rake install"

Prerequisites and setup:
------------------------
1. Uses pg driver - depends on Postgres being installed
2. Assumes 'rademade' database to be available for tests (change in spec/spec_helper.rb)
3. Assumes 'rademade' database to be available (change **DB_SETUP** in test_rakefile/Rakefile - all settings are passed to PG.connect() when establishing connection)
4. Assumes database has tables 'users' and 'posts' with correct schema

Usage:
------
1. Copy test_rakefile/Rakefile from this repo to the folder that contains folder with fixtures
2. Run "rake load_fixtures" (**assumes folder named "fixtures" to be in the directory**)
3. Can specify relative path to fixtures folder with "rake load_fixtures[relative_path]"
