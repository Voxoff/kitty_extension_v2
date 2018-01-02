class UsersController < ApplicationController
  def show
    @hidenav = false
    @hidebtn = false

    @user = current_user
    @group = current_group
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
end
