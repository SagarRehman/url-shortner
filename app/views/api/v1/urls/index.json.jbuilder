json.data do
	json.array! @url, partial: 'single_url_details', as: :url
end