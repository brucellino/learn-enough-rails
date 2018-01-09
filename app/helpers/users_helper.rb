module UsersHelper

    # Returns the gravatar for the user
    def gravatar_for(user, options = { size: 80 })
        size = options[:size]
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?size=#{size}"
        image_tag(gravatar_url, alt: user.name, class: "img img-rounded-circle")
    end


end
