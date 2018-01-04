class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  has_many :memberships
  has_many :groups, through: :memberships
  has_many :expenses
  has_many :splits

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.image = auth.info.image
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.gender = auth.extra.raw_info.gender
      user.age_range_minimum = auth.extra.raw_info.age_range.min[1]
      user.locale = auth.extra.raw_info.locale
      user.timezone = auth.extra.raw_info.timezone
    end
  end

  def outstanding_with_person_in_group(comparison_user, group)
    user_owed_splits = Split.joins(:expense).where(expenses: {user_id: self.id}).where(user_id: comparison_user.id).where(expenses: {group_id: group.id})
    user_owes_splits = Split.joins(:expense).where(expenses: {user_id: comparison_user.id}).where(user_id: self.id).where(expenses: {group_id: group.id})

    currency = self.preferred_currency

    user_owes_total = Money.new(0, currency)
    user_owed_total = Money.new(0, currency)

    user_owed_splits.each do |split|
      if split.amount_currency == currency
        user_owed_total += split.amount
      else
        exchange_rate_object = ExchangeRate.find_by(id: split.expense.exchange_rates_id)
        exchange_rate = exchange_rate_object[:rates][currency]
        Money.add_rate(split.amount_currency, currency, exchange_rate)
        split_amount_in_preferred_currency = split.amount.exchange_to(currency)
        user_owed_total += split_amount_in_preferred_currency
      end
    end

    user_owes_splits.each do |split|
      if split.amount_currency == currency
        user_owes_total += split.amount
      else
        exchange_rate_object = ExchangeRate.find_by(id: split.expense.exchange_rates_id)
        exchange_rate = exchange_rate_object[:rates][currency]
        Money.add_rate(split.amount_currency, currency, exchange_rate)
        split_amount_in_preferred_currency = split.amount.exchange_to(currency)
        user_owes_total += split_amount_in_preferred_currency
      end
    end

    return user_owed_total - user_owes_total
  end

  def outstanding_with_person_overall(comparison_user)
    user_owed_splits = Split.joins(:expense).where(expenses: {user_id: self.id}).where(user_id: comparison_user.id)
    user_owes_splits = Split.joins(:expense).where(expenses: {user_id: comparison_user.id}).where(user_id: self.id)

    currency = self.preferred_currency

    user_owes_total = Money.new(0, currency)
    user_owed_total = Money.new(0, currency)

    user_owed_splits.each do |split|
      if split.amount_currency == currency
        user_owed_total += split.amount
      else
        exchange_rate_object = ExchangeRate.find_by(id: split.expense.exchange_rates_id)
        exchange_rate = exchange_rate_object[:rates][currency]
        Money.add_rate(split.amount_currency, currency, exchange_rate)
        split_amount_in_preferred_currency = split.amount.exchange_to(currency)
        user_owed_total += split_amount_in_preferred_currency
      end
    end

    user_owes_splits.each do |split|
      if split.amount_currency == currency
        user_owes_total += split.amount
      else
        exchange_rate_object = ExchangeRate.find_by(id: split.expense.exchange_rates_id)
        exchange_rate = exchange_rate_object[:rates][currency]
        Money.add_rate(split.amount_currency, currency, exchange_rate)
        split_amount_in_preferred_currency = split.amount.exchange_to(currency)
        user_owes_total += split_amount_in_preferred_currency
      end
    end

    return user_owed_total - user_owes_total
  end

  def outstanding_with_group(group)
    user_owes_splits = Split.joins(:expense).where(user_id: self.id).where(expenses: {group_id: group.id})
    user_owed_splits = Split.joins(:expense).where(expenses: {user_id: self.id}).where(expenses: {group_id: group.id})

    currency = self.preferred_currency

    user_owes_total = Money.new(0, currency)
    user_owed_total = Money.new(0, currency)

    user_owed_splits.each do |split|
      if split.amount_currency == currency
        user_owed_total += split.amount
      else
        exchange_rate_object = ExchangeRate.find_by(id: split.expense.exchange_rates_id)
        exchange_rate = exchange_rate_object[:rates][currency]
        Money.add_rate(split.amount_currency, currency, exchange_rate)
        split_amount_in_preferred_currency = split.amount.exchange_to(currency)
        user_owed_total += split_amount_in_preferred_currency
      end
    end

    user_owes_splits.each do |split|
      if split.amount_currency == currency
        user_owes_total += split.amount
      else
        exchange_rate_object = ExchangeRate.find_by(id: split.expense.exchange_rates_id)
        exchange_rate = exchange_rate_object[:rates][currency]
        Money.add_rate(split.amount_currency, currency, exchange_rate)
        split_amount_in_preferred_currency = split.amount.exchange_to(currency)
        user_owes_total += split_amount_in_preferred_currency
      end
    end

    return user_owed_total - user_owes_total
  end
end
