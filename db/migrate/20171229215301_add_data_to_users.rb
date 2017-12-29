class AddDataToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :gender, :string
    add_column :users, :age_range_minimum, :string
    add_column :users, :locale, :string
    add_column :users, :timezone, :integer
    add_column :users, :seen_update, :boolean, default: false
    add_column :users, :preferred_currency, :string, default: "GBP"
  end
end
