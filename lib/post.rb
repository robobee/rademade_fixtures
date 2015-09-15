require_relative 'active_record'

class Post < ActiveRecord

  def attributes
    [:id, :name, :text]
  end

  def table_name
    'posts'
  end

  def self.table_name
    'posts'
  end

end
