class GroupsController < ApplicationController
  def new_kitty
    @hidebtn = true
    @hidenav = true
    @user = current_user
    @group = current_group
    @group.name = nil

  end

  def update
    @hidebtn = true
    @hidenav = true

    @user = current_user
    @group = current_group
    @group.name = params[:group][:name]
    if @group.name == ""
      render 'new_kitty'
    else
      @group.kitty_created = true
      @group.save
      redirect_to group_path(@group)
    end
  end

  def empty_group
    @hidebtn = true
    @hidenav = true
  end

  def show
    @hidebtn = false
    @hidenav = false

    @nav_title = "You're all square"

    @user = current_user
    @user.save

    @group = current_group
    @group.kitty_created = true
    @group.save
    @title = @group.name

    if @group.users.length == 1
      @hidebtn = true
      render 'empty_group'
    end

    # @user_owes_splits_to_group = Split.joins(:expense).where(user_id: @user.id).where(expenses: {group_id: @group.id})
    # @user_owed_splits_by_group = Split.joins(:expense).where(expenses: {user_id: @user.id}).where(expenses: {group_id: @group.id})
    # @user_outstanding_with_group = outstanding_with_group(@user_owes_splits_to_group, @user_owed_splits_by_group)
    # @nav_title = determine_navbar_title(@user_outstanding_with_group)
  end

  def reminder
    @title = "Send Reminder"
    @hidebtn = false
    @hidenav = false

    @user = current_user
    @group = current_group

    @owes_you = group_members_that_owe_you(@user, @group)

    if @owes_you.length == 0
      render 'no_one_owes'
    end
  end

  def no_one_owes
    @title = "No one to remind"
    @hidebtn = true
    @hidenav = true

    @user = current_user
    @group = current_group
  end

  private

  def group_members_that_owe_you(user, group)
    owes_you = []
    group.users.each do |member|
      if member == @user
      next
      elsif @user.outstanding_with_person_overall(member) == 0
      next
      elsif @user.outstanding_with_person_overall(member) < 0
      next
      else
        owes_you << member
      end
    end
    return owes_you
  end

  def outstanding_with_group(user_owes_splits, user_owed_splits)
    user_owes_total = 0
    user_owed_total = 0

    user_owed_splits.each do |split|
      user_owed_total += split.amount_cents
    end

    user_owes_splits.each do |split|
      user_owes_total += split.amount_cents
    end

    return user_owed_total - user_owes_total
  end

  def determine_navbar_title(user_outstanding_with_group)
    if user_outstanding_with_group.to_f == 0
      return "You're all square"
    elsif user_outstanding_with_group.to_f < 0
      return "You owe: £#{sprintf('%.2f', user_outstanding_with_group.to_f * -1 / 100)}"
    else
      "You are owed: £#{sprintf('%.2f', user_outstanding_with_group.to_f / 100)}"
    end
  end
end
