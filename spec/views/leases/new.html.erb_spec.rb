require 'spec_helper'

describe "leases/new" do
  before(:each) do
    assign(:lease, stub_model(Lease).as_new_record)
  end

  it "renders new lease form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", leases_path, "post" do
    end
  end
end
