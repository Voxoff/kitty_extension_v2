class CreateExchangeRates < ActiveRecord::Migration[5.1]
  def change
    create_table :exchange_rates do |t|
      t.string :base
      t.text :rates
      t.timestamps
    end
  end
end
