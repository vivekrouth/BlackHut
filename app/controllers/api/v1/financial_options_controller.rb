class Api::V1::FinancialOptionsController < ApplicationController

	def graph_values
		data = 1
		render json: {
		    success: true,
		    message: "graph data",
		    data: data
		}
	end

end
