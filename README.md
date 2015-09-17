Readme
======

Description:
------------
Fixture loader utility, packaged as a gem.

Installation instructions:
--------------------------
1. Clone this repository to local machine
2. Can run tests with "rspec sepc" (**assumes there is a pg database named 'rademade')**
3. Run "rake install"

Prerequisites and setup:
------------------------
1. Uses pg driver - depends on Postgres being installed
2. Assumes 'rademade' database to be available for tests (change in spec/spec_helper.rb)

Usage:
------
1. Copy rakefile/Rakefile from this repo to the folder that contains folder with fixtures
2. Run "rake load_fixtures" (**assumes folder named "fixtures" to be in the directory**)
3. Can specify relative path to fixtures folder with rake load_fixtures[relative_path]
