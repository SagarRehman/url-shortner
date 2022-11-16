module Api
	module V1
		class UrlsController < ApplicationController
			def index
				@url = Url.last_ten_records.includes(:clicks)
			end
		end
	end
end