class AddColumnToFinancialOptions < ActiveRecord::Migration
  def change
  	add_column :financial_options, :pricing, :decimal, :precision => 10, :scale => 2
  end
end
