module RademadeFixtures
  class UserFactory

    def create
      User.new
    end

    def create_from_hash(hash)
      post = User.new
      hash.each do |a, v|
        post.set(a.to_sym, v)
      end
      post
    end

  end
end
