class UsersController < ApplicationController
  def show
    @user = current_user
    @group = current_group
  end
end