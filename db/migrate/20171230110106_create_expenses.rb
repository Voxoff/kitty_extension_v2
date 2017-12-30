class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
      t.references :group, foreign_key: true
      t.references :user, foreign_key: true
      t.string :title
      t.string :split_type, default: "equal"
      t.string :location
      t.string :description
      t.string :payment_method, default: "card"
      t.monetize :amount

      t.timestamps
    end
  end
end
