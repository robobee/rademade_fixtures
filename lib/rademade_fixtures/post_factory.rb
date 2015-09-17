module RademadeFixtures
  class PostFactory

    def create
      Post.new
    end

    def create_from_hash(hash)
      post = Post.new
      hash.each do |a, v|
        post.set(a.to_sym, v)
      end
      post
    end

  end
end
