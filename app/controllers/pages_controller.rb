class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def call_facebook
    @user = current_user
  end

  def redirect
    @user = current_user
    @group = Group.find_by(tid: params[:tid])

    if @group
      puts "1. This is an already existing group... setting session"
      session[:current_group_id] = @group.id
      if @group.thread_type == "USER_TO_PAGE"
        redirect_to user_path(@user)
      else
        redirect_to group_path(@group)
      end
    else
      puts "1. This is a new group... creating..."
      @group = Group.create(tid: params[:tid], thread_type: params[:thread_type])
      puts "2. Setting group session"
      session[:current_group_id] = @group.id
      if @group.thread_type == "USER_TO_PAGE"
        puts "2. User-to-Page: Redirecting to User Profile"
        redirect_to user_path(@user)
      else
        puts "2. User-to-User: Redirecting to Group"
        redirect_to new_group_path(@group)
      end
    end
  end
end
