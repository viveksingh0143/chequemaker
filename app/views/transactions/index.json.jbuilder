json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :payee, :cheque_date, :amount, :account_payee, :user_id, :bank_id
  json.url transaction_url(transaction, format: :json)
end
