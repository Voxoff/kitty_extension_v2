class ExpensesController < ApplicationController
  def new
    @hidebtn = true
    @hidenav = false
    @tabs = ["Add", "Settle"]

    @user = current_user
    @group = current_group
    @expense = Expense.new
    @expense.amount_pennies = nil

    @owed_array = to_be_settled_with(@group)

    @eu_bank = EuCentralBank.new
    p @eu_bank

  end

  def create
    @hidebtn = false
    @hidenav = false
    @tabs = ["Add", "Settle"]

    @user = current_user
    @group = current_group

    @title = getparams[:title]
    @amount_pennies = getparams[:amount_pennies].to_f * 100
    @description = getparams[:description]
    @payment_method = payment_type
    @involved_group_string = get_involved_group(getparams[:involved_group], getparams[:settle_group])
    @location = getparams[:location]

    @expense = Expense.new(
        title: @title,
        description: @description,
        amount_pennies: @amount_pennies,
        amount_currency: "GBP",
        amount: Money.new(@amount_pennies, "GBP"),
        user_id: @user.id,
        group_id: @group.id,
        location: @location,
        payment_method: @payment_method)

    if @involved_group_string != "" && @involved_group_string != [@user.id.to_s] && @expense.save
      equal_splitter(@expense, @involved_group_string)
      redirect_to expense_path(@expense, user_id: @user.id, group_id: @group.id)
    else
      @hidebtn = true
      flash.now[:alert] = "You didn't select anyone"
      render :new
    end
  end

  def show
    @hidebtn = false
    @hidenav = false
    @expense = Expense.find(params[:id].to_i)
    @user = current_user
    @group = current_group
    @title = expense_show_title(@expense)
    @total_lent = total_lent(@expense)
  end

  private

  def to_be_settled_with(group)
    owed_array = []
    group.users.each do |member|
      if member == @user || @user.outstanding_with_person_in_group(member, @group) > 0
        owed_array << member
      end
    end
    return owed_array
  end

  def total_lent(expense)
    total_amount = Money.new(0, 'GBP')
    expense.splits.each do |split|
      total_amount += split.amount
    end
    return total_amount
  end

  def expense_show_title(expense)
    if expense.description == "Settled"
      return " #{expense.user.first_name} paid back #{expense.splits.first.user.first_name}"
    else
      return expense.title
    end
  end

  def equal_splitter(expense, involved_group_string)
    involved_group = involved_group_string.split(",")
    number_involved = involved_group.length
    an_equal_split = (expense.amount.cents / number_involved)
    involved_group.each do |member_id|
      if member_id.to_i == expense.user.id
        next
      end
      split = Split.new(expense_id: expense.id,
        user_id: member_id,
        amount_pennies: an_equal_split,
        amount_currency: "GBP",
        amount: Money.new(an_equal_split, "GBP"))
      split.save!
    end
  end

  def payment_type
    if getparams[:payment_method] = "" || getparams[:payment_method].nil?
      return "card"
    else
      return getparams[:payment_method].downcase
    end
  end

  def get_involved_group(params_involved_group, params_settle_group)
    new_group = params_involved_group
    settle_group = params_settle_group
    if new_group.nil?
      puts settle_group
      return settle_group
    else
      puts new_group
      return new_group
    end
  end

  def getparams
    params.require(:expense).permit(:id, :split_type, :location, :settle, :title, :amount_pennies, :description, :user_id, :group_id, :involved_group, :settle_group, :to_pay_id, :payment_method)
  end
end
