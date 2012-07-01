require "spec_helper"

describe RoleGroupsController do
  describe "routing" do

    it "routes to #index" do
      get("/role_groups").should route_to("role_groups#index")
    end

    it "routes to #new" do
      get("/role_groups/new").should route_to("role_groups#new")
    end

    it "routes to #show" do
      get("/role_groups/1").should route_to("role_groups#show", :id => "1")
    end

    it "routes to #edit" do
      get("/role_groups/1/edit").should route_to("role_groups#edit", :id => "1")
    end

    it "routes to #create" do
      post("/role_groups").should route_to("role_groups#create")
    end

    it "routes to #update" do
      put("/role_groups/1").should route_to("role_groups#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/role_groups/1").should route_to("role_groups#destroy", :id => "1")
    end

  end
end
