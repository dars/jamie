require 'spec_helper'

describe "leases/index" do
  before(:each) do
    assign(:leases, [
      stub_model(Lease),
      stub_model(Lease)
    ])
  end

  it "renders a list of leases" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
