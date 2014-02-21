class AddPaidStatusToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :paid_status, :boolean, :default => false
  end
end
