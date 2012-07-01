require "spec_helper"

describe LeaderHistoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/leader_histories").should route_to("leader_histories#index")
    end

    it "routes to #new" do
      get("/leader_histories/new").should route_to("leader_histories#new")
    end

    it "routes to #show" do
      get("/leader_histories/1").should route_to("leader_histories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/leader_histories/1/edit").should route_to("leader_histories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/leader_histories").should route_to("leader_histories#create")
    end

    it "routes to #update" do
      put("/leader_histories/1").should route_to("leader_histories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/leader_histories/1").should route_to("leader_histories#destroy", :id => "1")
    end

  end
end
