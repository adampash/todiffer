class SettingsController < ApplicationController

  def show
  end

  def update
    current_user.slack_username = params[:user][:slack_username]
    current_user.save
    redirect_to settings_path
  end
end

