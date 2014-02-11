class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.string :name
      t.string :account_number
      t.string :cheque_image
      t.boolean :status
      t.references :user, index: true

      t.timestamps
    end
  end
end
