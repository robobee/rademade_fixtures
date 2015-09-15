require_relative 'active_record'

class User < ActiveRecord

  def attributes
    [:id, :name, :last_name, :age]
  end

  def model_alias
    'user'
  end

end
