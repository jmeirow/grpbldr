require "spec_helper"

describe AgendaTopsController do
  describe "routing" do

    it "routes to #index" do
      get("/agenda_tops").should route_to("agenda_tops#index")
    end

    it "routes to #new" do
      get("/agenda_tops/new").should route_to("agenda_tops#new")
    end

    it "routes to #show" do
      get("/agenda_tops/1").should route_to("agenda_tops#show", :id => "1")
    end

    it "routes to #edit" do
      get("/agenda_tops/1/edit").should route_to("agenda_tops#edit", :id => "1")
    end

    it "routes to #create" do
      post("/agenda_tops").should route_to("agenda_tops#create")
    end

    it "routes to #update" do
      put("/agenda_tops/1").should route_to("agenda_tops#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/agenda_tops/1").should route_to("agenda_tops#destroy", :id => "1")
    end

  end
end
