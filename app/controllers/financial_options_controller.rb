class FinancialOptionsController < ApplicationController
	
	def index
		@financial_options = FinancialOption.all
	end

	def new
	end
	
	def create
		@financial_option = FinancialOption.new(financial_params)
		@financial_option.save
		redirect_to @financial_option
	end
	
	def show
		@financial_option = FinancialOption.find(params[:id])
	end

	private
		def financial_params
			params.require(:financial_option).permit(:strike_price, :stock_price, 
							:volatility, :interest_rate, :time_period, :parity_type)
		end
end
