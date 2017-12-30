class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string "tid"
      t.string "name", default: "Your Kitty"
      t.string "thread_type"
      t.boolean "kitty_created", default: false
      t.boolean "closed", default: false

      t.timestamps
    end
  end
end
