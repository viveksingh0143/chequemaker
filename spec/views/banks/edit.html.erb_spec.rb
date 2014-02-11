require 'spec_helper'

describe "banks/edit" do
  before(:each) do
    @bank = assign(:bank, stub_model(Bank,
      :name => "MyString",
      :account_number => "MyString",
      :cheque_image => "MyString",
      :status => false,
      :user => nil
    ))
  end

  it "renders the edit bank form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", bank_path(@bank), "post" do
      assert_select "input#bank_name[name=?]", "bank[name]"
      assert_select "input#bank_account_number[name=?]", "bank[account_number]"
      assert_select "input#bank_cheque_image[name=?]", "bank[cheque_image]"
      assert_select "input#bank_status[name=?]", "bank[status]"
      assert_select "input#bank_user[name=?]", "bank[user]"
    end
  end
end
