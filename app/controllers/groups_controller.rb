class GroupsController < ApplicationController
  def new_kitty
    @user = current_user
    if session[:current_group_id]
      puts "*****************************"
      puts "Session exists"
      puts "*****************************"
    else
      session[:current_group_id] = params[:group_id].to_i
    end
    @group = current_group
    @group.name = "name change"

  end

  def update
    @user = current_user
    @group = current_group
    @group.name = params[:group][:name]
    if @group.name == ""
      render 'new_kitty'
    else
      @group.save
      redirect_to group_path(@group)
    end
  end

  def show
    # @user = User.find(params[:user_id])
    # # @user.first_sign_in = false
    # # @user.save
    # @group = Group.find(params[:group_id])
    # @group.kitty_created = true
    # @group.save
    # @user_owes_splits_to_group = Split.joins(:expense).where(user_id: @user.id).where(expenses: {group_id: @group.id})
    # @user_owed_splits_by_group = Split.joins(:expense).where(expenses: {user_id: @user.id}).where(expenses: {group_id: @group.id})
    # @user_outstanding_with_group = outstanding_with_group(@user_owes_splits_to_group, @user_owed_splits_by_group)
    # @nav_title = determine_navbar_title(@user_outstanding_with_group)
    # @params_controller = params["controller"]
    # @params_action = params["action"]
    @group = current_group
  end
end
