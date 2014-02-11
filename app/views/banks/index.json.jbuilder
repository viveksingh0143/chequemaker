json.array!(@banks) do |bank|
  json.extract! bank, :id, :name, :account_number, :cheque_image, :status, :user_id
  json.url bank_url(bank, format: :json)
end
