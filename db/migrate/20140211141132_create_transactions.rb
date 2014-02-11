class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :payee
      t.datetime :cheque_date
      t.float :amount
      t.boolean :account_payee
      t.references :user, index: true
      t.references :bank, index: true

      t.timestamps
    end
  end
end
