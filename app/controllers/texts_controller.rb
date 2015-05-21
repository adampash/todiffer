class TextsController < ApplicationController
  protect_from_forgery :except => [:create]
  before_action :authenticate_user!, only: [:create, :index, :new]

  def index
    @texts = current_user.followed_texts
  end

  def create
    selector = params[:text][:selector].empty? ? nil : params[:text][:selector]
    text = Text.find_or_create(
      url:      params[:text][:url],
      selector: selector,
      user:     current_user,
    )

    if text
      redirect_to texts_path
    end
  end

  def new
    @text = Text.new
  end

  def show
    @text = Text.find params[:id]
  end

end
