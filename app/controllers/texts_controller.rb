class TextsController < ApplicationController
  protect_from_forgery :except => [:create]
  # before_action :authenticate_user!, only: [:create]
  def create
    Text.find_or_create params[:url], nil
  end

end
