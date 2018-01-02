class UsersController < ApplicationController
  def show
    @hidenav = false
    @hidebtn = false

    @user = current_user
    @group = current_group

    @balance = get_user_balance(@user)
    @expenses_paid = Expense.where(user_id: @user.id)
    @amount_lent = amount_lent(@expenses_paid)
    @splits_owed = Split.where(user_id: @user.id)
    @amount_borrowed = amount_borrowed(@splits_owed)
  end

  def transactions
    @hidebtn = false
    @hidenav = false
    @tabs = ["Group", "All"]

    @user = current_user
    @group = current_group
    @transactions = all_user_transactions(@user)
    @transaction_dates = get_all_dates_transacted_upon(@transactions)
    @in_group_transactions = filter_transactions_for_group(@transactions, @group)
    @in_group_transaction_dates = get_all_dates_transacted_upon_in_group(@in_group_transactions)
  end

  def friends
    @hidebtn = false
    @hidenav = false

    @user = current_user
    @group = current_group
    @users = User.all

    @users_user_owed_by = users_user_owed_by(@user, @users)
    @users_user_owes = users_user_owes(@user, @users)
  end

  private

  def all_user_transactions(user)
    transactions = []
    expenses_paid = Expense.where(user_id: user.id)
    p expenses_paid
    splits_owed = Split.where(user_id: user.id)
    p splits_owed

    expenses_paid.each do |expense|
      transactions << expense
    end
    splits_owed.each do |split|
      transactions << split
    end
    return transactions.sort_by { |item| item.created_at }.reverse
  end

  def filter_transactions_for_group(transactions, group)
    filtered_transactions = []
    unless group == "no_group"
      transactions.each do |transaction|
        if transaction.group.id == group.id
          filtered_transactions << transaction
        end
      end
    end
    return filtered_transactions
  end

  def get_all_dates_transacted_upon(transactions)
    dates = []
    transactions.each do |transaction|
      dates << transaction.created_at.strftime("%d/%m/%Y")
    end
    p dates.uniq
    return dates.uniq
  end

  def get_all_dates_transacted_upon_in_group(transactions)
    dates = []
    transactions.each do |transaction|
      dates << transaction.created_at.strftime("%d/%m/%Y")
    end
    p dates.uniq
    return dates.uniq
  end

  def get_user_balance(user)
    balance_cents = 0
    @user.groups.each do |group|
      balance_cents += @user.outstanding_with_group(group)
    end
    return balance_cents
  end

  def amount_lent(expenses_paid)
    amount_lent = 0
    expenses_paid.each do |expense|
      amount_lent += expense.amount_pennies
    end
    return amount_lent
  end

  def amount_borrowed(splits_owed)
    amount_borrowed = 0
    splits_owed.each do |split|
      amount_borrowed += split.amount_pennies
    end
    return amount_borrowed
  end

  def users_user_owed_by(current_user, users)
    users_owed = []
    users.each do |user|
      if current_user.outstanding_with_person_overall(user) > 0
        users_owed << user
      end
    end
    return users_owed
  end

  def users_user_owes(current_user, users)
    users_owes = []
    users.each do |user|
      if current_user.outstanding_with_person_overall(user) < 0
        users_owes << user
      end
    end
    return users_owes
  end
end
