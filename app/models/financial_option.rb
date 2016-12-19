class FinancialOption < ActiveRecord::Base
	validates :strike_price, presence: true, length: { in: 1..10 }, :numericality => true, :allow_nil => false
	validates :stock_price, presence: true, length: { in: 1..10 }, :numericality => true, :allow_nil => false
	validates :time_period, presence: true, length: { in: 1..8 }, :numericality => true, :allow_nil => false
	validates :volatility, presence: true, length: { in: 1..10 }, :numericality => true, :allow_nil => false
	validates :interest_rate, presence: true, length: { in: 1..10 }, :numericality => true, :allow_nil => false
	validates :parity_type, presence: true, :numericality => true, :allow_nil => false
	after_create :saveBSMPricing

	private
		# Cumulative normal distribution
		def cnd(x)
			a1, a2, a3, a4, a5 = 0.31938153, -0.356563782, 1.781477937, -1.821255978, 1.330274429
			l = x.abs
			k = 1.0 / (1.0 + 0.2316419 * l)
			w = 1.0 - 1.0 / Math.sqrt(2*Math::PI)*Math.exp(-l*l/2.0) * (a1*k + a2*k*k + a3*(k**3) + a4*(k**4) + a5*(k**5))
			w = 1.0 - w if x < 0
			return w
		end

		def BlackScholes(callPutFlag, stock, strike, timePeriod, rate, volatility)
			d1 = (Math.log(stock/strike)+(rate+volatility*volatility/2.0)*timePeriod)/(volatility*Math.sqrt(timePeriod))
			d2 = d1-volatility*Math.sqrt(timePeriod)
			if callPutFlag == 0 # call parity
				return stock*cnd(d1)-strike*Math.exp(-rate*timePeriod)*cnd(d2)
			else # put parity
				return strike*Math.exp(-rate*timePeriod)*cnd(-d2)-stock*cnd(-d1)
			end
		end

		def saveBSMPricing
			strike = self.strike_price
			stock = self.stock_price
			tme = self.time_period
			vol = self.volatility
			rate = self.interest_rate
			parity = self.parity_type
			temp = BlackScholes(parity, stock, strike, tme, rate, vol)
			self.update_attributes(:pricing => temp)
		end
end
