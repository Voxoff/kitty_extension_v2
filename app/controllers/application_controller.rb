class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def current_group
    Group.find_by(id: session[:current_group_id])
  end
end
