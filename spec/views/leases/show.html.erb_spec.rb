require 'spec_helper'

describe "leases/show" do
  before(:each) do
    @lease = assign(:lease, stub_model(Lease))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
