class AddExchangeRatesToExpense < ActiveRecord::Migration[5.1]
  def change
    add_column :expenses, :exchange_rates_snapshot, :text
  end
end
