class AddReceivedToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :received, :boolean
  end
end
