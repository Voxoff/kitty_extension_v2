class ChangeExchangeRatesSnapshotColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :expenses, :exchange_rates_snapshot
    add_reference :expenses, :exchange_rates, foreign_key: true
  end
end
