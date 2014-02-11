require 'spec_helper'

describe "banks/show" do
  before(:each) do
    @bank = assign(:bank, stub_model(Bank,
      :name => "Name",
      :account_number => "Account Number",
      :cheque_image => "Cheque Image",
      :status => false,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Account Number/)
    expect(rendered).to match(/Cheque Image/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
  end
end
