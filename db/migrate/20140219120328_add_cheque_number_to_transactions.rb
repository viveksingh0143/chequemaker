class AddChequeNumberToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :cheque_number, :integer, :default => 0
  end
end
