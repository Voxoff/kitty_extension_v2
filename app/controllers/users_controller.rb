class UsersController < ApplicationController
  def show
    @hidenav = false
    @hidebtn = false

    @user = current_user
    @group = current_group
  end
end
