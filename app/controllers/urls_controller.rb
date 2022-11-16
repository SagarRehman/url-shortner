# frozen_string_literal: true

class UrlsController < ApplicationController
  before_action :set_url, only: %i[visit show]

  def index
    @url = Url.new
    @urls = Url.last_ten_records
  end

  def create
    @url = UrlCreator.call(url_params)
    flash[:notice] = 'Please add a valid URL' if @url.instance_of?(Hash)

    redirect_to root_path
  end

  def show
    return render file: "#{Rails.root}/public/404.html", layout: false, status: 404 unless @url

    @daily_clicks = @url.daily_clicks
    @browsers_clicks = @url.browser_clicks
    @platform_clicks = @url.platform_clicks
  end

  def visit
    # params[:short_url]
    return render file: "#{Rails.root}/public/404.html", layout: false, status: 404 unless @url

    browser = Browser.new(request.env['HTTP_USER_AGENT'], accept_language: 'en-us')
    @url.clicks.create(browser: browser.name, platform: browser.platform.name)
    redirect_to(@url.original_url)
  end

  private

  def set_url
    @url = Url.find_by_short_url(params[:short_url] || params[:url])
  end

  def url_params
    params.require(:url).permit(:original_url)
  end
end
