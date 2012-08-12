require "spec_helper"

describe ContestSignupsController do
  describe "routing" do

    it "routes to #index" do
      get("/contest_signups").should route_to("contest_signups#index")
    end

    it "routes to #new" do
      get("/contest_signups/new").should route_to("contest_signups#new")
    end

    it "routes to #show" do
      get("/contest_signups/1").should route_to("contest_signups#show", :id => "1")
    end

    it "routes to #edit" do
      get("/contest_signups/1/edit").should route_to("contest_signups#edit", :id => "1")
    end

    it "routes to #create" do
      post("/contest_signups").should route_to("contest_signups#create")
    end

    it "routes to #update" do
      put("/contest_signups/1").should route_to("contest_signups#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/contest_signups/1").should route_to("contest_signups#destroy", :id => "1")
    end

  end
end
