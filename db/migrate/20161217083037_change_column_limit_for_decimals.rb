class ChangeColumnLimitForDecimals < ActiveRecord::Migration
  def change
  	change_column :financial_options, :strike_price, :decimal, :precision => 10, :scale => 2
  	change_column :financial_options, :stock_price, :decimal, :precision => 10, :scale => 2
  	change_column :financial_options, :volatility, :decimal, :precision => 10, :scale => 2
  	change_column :financial_options, :interest_rate, :decimal, :precision => 10, :scale => 2
  	change_column :financial_options, :time_period, :integer, :limit => 8
  	change_column :financial_options, :parity_type, :integer, :default => 0
  end
end
