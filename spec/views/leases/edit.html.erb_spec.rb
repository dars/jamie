require 'spec_helper'

describe "leases/edit" do
  before(:each) do
    @lease = assign(:lease, stub_model(Lease))
  end

  it "renders the edit lease form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", lease_path(@lease), "post" do
    end
  end
end
