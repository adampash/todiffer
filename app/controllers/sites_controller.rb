class SitesController < ApplicationController
  def show
    @site = Site.find(params[:id])
    @texts = @site.texts
  end

  def index
    @sites = Site.all
  end
end
