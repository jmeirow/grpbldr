require "spec_helper"

describe RoleGroupAssociationsController do
  describe "routing" do

    it "routes to #index" do
      get("/role_group_associations").should route_to("role_group_associations#index")
    end

    it "routes to #new" do
      get("/role_group_associations/new").should route_to("role_group_associations#new")
    end

    it "routes to #show" do
      get("/role_group_associations/1").should route_to("role_group_associations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/role_group_associations/1/edit").should route_to("role_group_associations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/role_group_associations").should route_to("role_group_associations#create")
    end

    it "routes to #update" do
      put("/role_group_associations/1").should route_to("role_group_associations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/role_group_associations/1").should route_to("role_group_associations#destroy", :id => "1")
    end

  end
end
