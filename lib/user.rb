require_relative 'active_record'

class User < ActiveRecord

  def attributes
    [:id, :name, :last_name, :age]
  end

  def table_name
    'users'
  end

  def self.table_name
    'users'
  end

  def self.attributes
    [:id, :name, :last_name, :age]
  end

end
