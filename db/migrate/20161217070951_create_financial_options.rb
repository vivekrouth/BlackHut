class CreateFinancialOptions < ActiveRecord::Migration
  def change
    create_table :financial_options do |t|
      t.decimal :strike_price
      t.decimal :stock_price
      t.decimal :volatility
      t.decimal :interest_rate
      t.integer :time_period
      t.boolean :parity_type

      t.timestamps null: false
    end
  end
end
