class AddPaidStatusToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :paid_status, :integer
  end
end
