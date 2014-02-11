require 'spec_helper'

describe "transactions/edit" do
  before(:each) do
    @transaction = assign(:transaction, stub_model(Transaction,
      :payee => "MyString",
      :amount => 1.5,
      :account_payee => false,
      :user => nil,
      :bank => nil
    ))
  end

  it "renders the edit transaction form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", transaction_path(@transaction), "post" do
      assert_select "input#transaction_payee[name=?]", "transaction[payee]"
      assert_select "input#transaction_amount[name=?]", "transaction[amount]"
      assert_select "input#transaction_account_payee[name=?]", "transaction[account_payee]"
      assert_select "input#transaction_user[name=?]", "transaction[user]"
      assert_select "input#transaction_bank[name=?]", "transaction[bank]"
    end
  end
end
