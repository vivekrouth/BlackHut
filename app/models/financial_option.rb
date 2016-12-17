class FinancialOption < ActiveRecord::Base
	validates :strike_price, presence: true, length: { in: 1..10 }, :numericality => true, :allow_nil => false
	validates :stock_price, presence: true, length: { in: 1..10 }, :numericality => true, :allow_nil => false
	validates :time_period, presence: true, length: { in: 1..8 }, :numericality => true, :allow_nil => false
	validates :volatility, presence: true, length: { in: 1..10 }, :numericality => true, :allow_nil => false
	validates :interest_rate, presence: true, length: { in: 1..10 }, :numericality => true, :allow_nil => false
	validates :parity_type, presence: true, :numericality => true, :allow_nil => false
end
