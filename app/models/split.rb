class Split < ApplicationRecord
  monetize :amount_pennies, :as => "amount"

  belongs_to :expense
  belongs_to :user
  def group
    expense.group
  end
end
