require "spec_helper"

describe SysConfigurationsController do
  describe "routing" do

    it "routes to #index" do
      get("/sys_configurations").should route_to("sys_configurations#index")
    end

    it "routes to #new" do
      get("/sys_configurations/new").should route_to("sys_configurations#new")
    end

    it "routes to #show" do
      get("/sys_configurations/1").should route_to("sys_configurations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/sys_configurations/1/edit").should route_to("sys_configurations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/sys_configurations").should route_to("sys_configurations#create")
    end

    it "routes to #update" do
      put("/sys_configurations/1").should route_to("sys_configurations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/sys_configurations/1").should route_to("sys_configurations#destroy", :id => "1")
    end

  end
end
