# frozen_string_literal: true

FactoryBot.define do
  factory :url do
    short_url { 'ABCDE' }
    sequence(:original_url) { |i| "https://domain#{i}.com/path" }
	  
    trait :with_invalid_url do
	    original_url { 'http://@@@@ASDASD@@@ASD.com' }
    end
  end
end
