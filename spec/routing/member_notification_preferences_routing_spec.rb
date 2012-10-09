require "spec_helper"

describe MemberNotificationPreferencesController do
  describe "routing" do

    it "routes to #index" do
      get("/member_notification_preferences").should route_to("member_notification_preferences#index")
    end

    it "routes to #new" do
      get("/member_notification_preferences/new").should route_to("member_notification_preferences#new")
    end

    it "routes to #show" do
      get("/member_notification_preferences/1").should route_to("member_notification_preferences#show", :id => "1")
    end

    it "routes to #edit" do
      get("/member_notification_preferences/1/edit").should route_to("member_notification_preferences#edit", :id => "1")
    end

    it "routes to #create" do
      post("/member_notification_preferences").should route_to("member_notification_preferences#create")
    end

    it "routes to #update" do
      put("/member_notification_preferences/1").should route_to("member_notification_preferences#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/member_notification_preferences/1").should route_to("member_notification_preferences#destroy", :id => "1")
    end

  end
end
