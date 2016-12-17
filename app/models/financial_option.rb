class FinancialOption < ActiveRecord::Base
	validates :strike_price, presence: true, length: { in: 1..10 }
	validates :stock_price, presence: true, length: { in: 1..10 }
	validates :time_period, presence: true, length: { in: 1..8 }
	validates :volatility, presence: true, length: { in: 1..10 }
	validates :interest_rate, presence: true, length: { in: 1..10 }
	validates :parity_type, presence: true
end
