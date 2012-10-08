require "spec_helper"

describe NotificationTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/notification_types").should route_to("notification_types#index")
    end

    it "routes to #new" do
      get("/notification_types/new").should route_to("notification_types#new")
    end

    it "routes to #show" do
      get("/notification_types/1").should route_to("notification_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/notification_types/1/edit").should route_to("notification_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/notification_types").should route_to("notification_types#create")
    end

    it "routes to #update" do
      put("/notification_types/1").should route_to("notification_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/notification_types/1").should route_to("notification_types#destroy", :id => "1")
    end

  end
end
