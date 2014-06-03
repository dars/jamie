require "spec_helper"

describe LeasesController do
  describe "routing" do

    it "routes to #index" do
      get("/leases").should route_to("leases#index")
    end

    it "routes to #new" do
      get("/leases/new").should route_to("leases#new")
    end

    it "routes to #show" do
      get("/leases/1").should route_to("leases#show", :id => "1")
    end

    it "routes to #edit" do
      get("/leases/1/edit").should route_to("leases#edit", :id => "1")
    end

    it "routes to #create" do
      post("/leases").should route_to("leases#create")
    end

    it "routes to #update" do
      put("/leases/1").should route_to("leases#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/leases/1").should route_to("leases#destroy", :id => "1")
    end

  end
end
