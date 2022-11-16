# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'validations' do
	  
	  context 'validates original URL is a valid URL' do
		  subject { FactoryBot.create(:url) }
		  it { should validate_url_of(:url).be_valid }
	  end

	  context 'validates original URL is an invalid URL' do
		  subject { FactoryBot.build(:url, :with_invalid_url) }
		  it { should_not validate_url_of(:url).be_valid }
	  end
	  
	  context 'Verify uniqueness and length' do
		  it { should validate_presence_of(:short_url) }
		  
		  it { should validate_length_of(:short_url).is_equal_to(5) }
		
		  it { should allow_value('ABCDE').for(:short_url) }
		
		  it { should_not allow_value('ABCD@').for(:short_url) }
		
		  it { should_not allow_value('     ').for(:short_url) }
	  end
	  
	  context 'Verify assoications' do
		  it { should have_many(:clicks).dependent(:destroy) }
	  end
  end
end
