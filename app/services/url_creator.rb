class UrlCreator
	def initialize(url_parameter)
		@url_parameter = url_parameter
	end
	
	def self.call(*agrs)
		new(*agrs).send(:create_url)
	end
	
	private
	
	def create_url
		url = Url.new(@url_parameter.merge!({ short_url: generate_short_code }))
		url.save ? url : { errors: url.errors }
	end
	
	def generate_short_code
		code = [*'A'..'Z'].shuffle[0..4].join
		generate_short_code if Url.find_by_short_url(code)
		code
	end
end