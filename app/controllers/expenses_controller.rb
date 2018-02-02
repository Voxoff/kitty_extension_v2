require 'ocr_space'

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
  end

  def create
    @hidebtn = false
    @hidenav = false
    @tabs = ["Add", "Settle"]

    @user = current_user
    @group = current_group

    @title = getparams[:title]
    @amount_currency = getparams[:amount_currency]
    @amount_pennies = getparams[:amount_pennies].to_f * 100
    @description = getparams[:description]
    @payment_method = payment_type
    @involved_group_string = get_involved_group(getparams[:involved_group], getparams[:settle_group])
    @location = getparams[:location]
    @exchange_rates_snapshot_id = ExchangeRate.where(base: @amount_currency).last.id

    @expense = Expense.new(
        title: @title,
        description: @description,
        amount_pennies: @amount_pennies,
        amount_currency: @amount_currency,
        amount: Money.new(@amount_pennies, @amount_currency),
        user_id: @user.id,
        group_id: @group.id,
        location: @location,
        payment_method: @payment_method)
    @expense.exchange_rates_id = @exchange_rates_snapshot_id

    if @involved_group_string != "" && @involved_group_string != [@user.id.to_s] && @expense.save
      equal_splitter(@expense, @involved_group_string)
      redirect_to expense_path(@expense)
    else
      @hidebtn = true
      flash.now[:alert] = "You didn't select anyone"
      render :new
    end
  end

  def show
    @hidebtn = false
    @hidenav = false

    @user = current_user
    @group = current_group

    @expense = Expense.find(params[:id].to_i)
    @title = expense_show_title(@expense)

    @converted_amount = convert_expense(@user, @expense)
    @total_lent = total_lent(@expense)
    @total_lent_converted = total_lent_converted(@user, @expense)
  end

  def upload 
    puts "in da house"
    resource = OcrSpace::Resource.new(apikey: "#{ENV['ocr_space_key']}")
    result = resource.convert file: "/home/guy/code/Voxoff/machineLearning/tesseract/python/final.jpg"
    puts result
    redirect_to new_expense_path
  end

  private

  def convert_expense(user, expense)
    preferred_currency = user.preferred_currency
    if preferred_currency == expense.amount_currency
      return "Already in preferred currency"
    else
      exchange_rate_object = ExchangeRate.find_by(id: expense.exchange_rates_id)
      exchange_rate = exchange_rate_object[:rates][preferred_currency]
      Money.add_rate(expense.amount_currency, preferred_currency, exchange_rate)
      return expense.amount.exchange_to(preferred_currency)
    end
  end

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
    total_amount = Money.new(0, expense.amount_currency)
    expense.splits.each do |split|
      total_amount += split.amount
    end
    return total_amount
  end

  def total_lent_converted(user, expense)
    preferred_currency = user.preferred_currency
    total_amount = Money.new(0, preferred_currency)
    exchange_rate_object = ExchangeRate.find_by(id: expense.exchange_rates_id)
    exchange_rate = exchange_rate_object[:rates][preferred_currency]
    Money.add_rate(expense.amount_currency, preferred_currency, exchange_rate)
    expense.splits.each do |split|
      total_amount += split.amount.exchange_to(preferred_currency)
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
        amount_currency: expense.amount_currency,
        amount: Money.new(an_equal_split, expense.amount_currency))
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
    params.require(:expense).permit(:id, :split_type, :location, :settle, :title, :amount_currency, :amount_pennies, :description, :user_id, :group_id, :involved_group, :settle_group, :to_pay_id, :payment_method)
  end
end
