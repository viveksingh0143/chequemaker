class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :bank
  
  validates :payee, presence: true
  validates :cheque_date, presence: true
  validates :amount, presence: true
  validates :user, presence: true
  validates :bank, presence: true
  
  def self.by_debit(debit)
    if !debit.nil?
      if debit && (debit.to_s == "true" || debit == 'yes')
        debit_status = true
      else
        debit_status = false
      end
      where(paid_status: debit_status)
    else
      where(nil)
    end
  end

  
  def self.search(search_column, search_text)
    if search_text
      where("#{search_column} LIKE ?", "%#{search_text}%")
    else
      where(nil)
    end
  end
  
  def self.having_banks(bank_ids)
    if bank_ids
      where("bank_id IN (?)", bank_ids)
    else
      where(nil)
    end
  end
end
