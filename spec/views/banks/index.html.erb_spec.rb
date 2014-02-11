require 'spec_helper'

describe "banks/index" do
  before(:each) do
    assign(:banks, [
      stub_model(Bank,
        :name => "Name",
        :account_number => "Account Number",
        :cheque_image => "Cheque Image",
        :status => false,
        :user => nil
      ),
      stub_model(Bank,
        :name => "Name",
        :account_number => "Account Number",
        :cheque_image => "Cheque Image",
        :status => false,
        :user => nil
      )
    ])
  end

  it "renders a list of banks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Account Number".to_s, :count => 2
    assert_select "tr>td", :text => "Cheque Image".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
