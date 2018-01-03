class UpdateOldExpenseExchangeRateIds < ActiveRecord::Migration[5.1]
  def change
    Expense.all.each do |expense|
      expense.exchange_rates_id = 1
      expense.save
    end
  end
end
