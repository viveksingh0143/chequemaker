# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin_user = User.find_by_username("admin")
admin_user ||= User.create(username: "admin", email: 'admin@admin.com', password: 'p@ssw0rd', password_confirmation: 'p@ssw0rd', admin: true)

subscriber_user = User.find_by_username("subscriber")
subscriber_user ||= User.create(username: "subscriber", email: 'subscriber1@subscriber.com', password: 'p@ssw0rd', password_confirmation: 'p@ssw0rd', admin: true)

sbi_bank = Bank.find_by_name('State Bank of India')
sbi_bank ||= Bank.create(name: "State Bank of India", account_number: '1234567890987654', user: subscriber_user, status: true)

icici_bank = Bank.find_by_name('ICICI Bank')
icici_bank ||= Bank.create(name: "ICICI Bank", account_number: '2334567890987654', user: subscriber_user, status: true)

hdfc_bank = Bank.find_by_name('HDFC Bank')
hdfc_bank ||= Bank.create(name: "HDFC Bank", account_number: '4334567890987654', user: subscriber_user, status: true)

for i in 0..2000
  n = i%5
  Transaction.create(payee: "ABC #{n} Company", amount: Random.rand(999999999), cheque_date: Time.at(rand * (100.days.ago.to_f - Time.now.to_f) + Time.now.to_f), account_payee: [true, false].sample, bank: [sbi_bank, icici_bank, hdfc_bank].sample, user:subscriber_user)
end



#case Rails.env
#when "development"
#   ...
#when "production"
#   ...
#end
