module ApplicationHelper

	def avatar_url(user)
		gravatar_id = Digest::MD5::hexdigest(user.email).downcase
		@link = "https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=identical&s=150"

		def gravatar_error_code
			Net::HTTP.get_response(URI(@link)).code
		end

		if user.image
			@link
		elsif gravatar_error_code != 200
			@link = '' # no images have been found via gravatar
		else
			@link	
		end
	end

end
