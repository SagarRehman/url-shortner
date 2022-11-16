# frozen_string_literal: true

class Url < ApplicationRecord
  validates :original_url, url: true

  validates :short_url, presence: true, uniqueness: true, case_sensitive: false,
                        length: { is: 5 }, format: { with: /[A-Z]{5}/ }

  has_many :clicks, dependent: :destroy

  scope :last_ten_records, -> { order(created_at: :desc).limit(10) }

  def daily_clicks
    clicks.where('created_at > ? AND created_at < ?', Time.now.beginning_of_month,
                 Time.now).group("DATE_TRUNC('day', created_at)").count.map.with_index do |record, index|
      [index + 1, record[1]]
    end
  end

  def browser_clicks
    clicks.group(:browser).count.to_a
  end

  def platform_clicks
    clicks.group(:platform).count.to_a
  end
end
