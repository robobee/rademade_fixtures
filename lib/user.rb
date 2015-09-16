require_relative 'active_record'

class User < ActiveRecord

  def self.table_name
    'users'
  end

  def self.attributes
    [:id, :name, :last_name, :age]
  end

end
