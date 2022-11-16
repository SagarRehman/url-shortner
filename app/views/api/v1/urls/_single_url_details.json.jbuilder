json.type 'Url'
json.id url.id
json.attributes do
	json.created_at url.created_at
	json.original_url url.original_url
	json.url "https//domain/#{url.short_url}"
	json.clicks url.clicks_count
end

json.relationship do
	json.clicks do
		json.data do
			json.array! url.clicks, partial: 'click_details', as: :click
		end
	end
end