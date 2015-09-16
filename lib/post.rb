require_relative 'active_record'

class Post < ActiveRecord

  def self.attributes
    [:id, :name, :text]
  end

  def self.table_name
    'posts'
  end

end
