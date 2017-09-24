class UrlsController < ApplicationController

  def index
    @url = Url.new
    @urls = Url.all
  end

  def create
    url = Url.new(url_params)
    url.save!
    if url.save!
      #generate short url
      url.update!(short_url: SecureRandom.base64(5).split("=").first)
      redirect_to root_path
    else
      render :index
    end
  end

  def show
    @url = Url.find_by_short_url(params[:id])
    redirect_to @url.long_url
  end


  private

  def url_params
    params.require(:url).permit(:long_url)
  end
end
