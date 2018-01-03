class Expense < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_many :splits, :dependent => :destroy
  has_many :payees, through: :splits, class_name: "User", foreign_key: :user_id

  validates :amount_pennies, presence: true
  monetize :amount_pennies, :as => "amount"
  validates :title, presence: true
  validates :split_type, presence: true
  validates :amount_pennies, numericality: { greater_than: 0 }

  serialize :exchange_rates_snapshot

  def total_owed_back
    owed_back = 0
    self.splits.each do |split|
      owed_back += split.amount_pennies
    end
    return owed_back
  end
end
