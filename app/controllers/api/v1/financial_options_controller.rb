class Api::V1::FinancialOptionsController < ApplicationController

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

	def graph_values
		if !params[:q].nil?
			if params[:q][:type].to_i == 1 # strike price
				data = BlackScholes(params[:q][:v5].to_i, params[:q][:v1].to_f, params[:q][:v6].to_f, params[:q][:v2].to_i, params[:q][:v4].to_f, params[:q][:v3].to_f)
			elsif params[:q][:type].to_i == 2 # stock price
				data = BlackScholes(params[:q][:v5].to_i, params[:q][:v6].to_f, params[:q][:v1].to_f, params[:q][:v2].to_i, params[:q][:v4].to_f, params[:q][:v3].to_f)
			elsif params[:q][:type].to_i == 3 # time period
				data = BlackScholes(params[:q][:v5].to_i, params[:q][:v2].to_f, params[:q][:v1].to_f, params[:q][:v6].to_i, params[:q][:v4].to_f, params[:q][:v3].to_f)
			elsif params[:q][:type].to_i == 4 # volatility
				data = BlackScholes(params[:q][:v5].to_i, params[:q][:v2].to_f, params[:q][:v1].to_f, params[:q][:v3].to_i, params[:q][:v4].to_f, params[:q][:v6].to_f)
			elsif params[:q][:type].to_i == 5 # interest rate
				data = BlackScholes(params[:q][:v5].to_i, params[:q][:v2].to_f, params[:q][:v1].to_f, params[:q][:v3].to_i, params[:q][:v6].to_f, params[:q][:v4].to_f)
			end
			render json: {
			    success: true,
			    message: "graph data",
			    data: data
			}
		else
			render json: {
			    success: true,
			    message: "graph data",
			    data: 'null'
			}
		end
	end

end
