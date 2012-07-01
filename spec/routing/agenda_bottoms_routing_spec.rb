require "spec_helper"

describe AgendaBottomsController do
  describe "routing" do

    it "routes to #index" do
      get("/agenda_bottoms").should route_to("agenda_bottoms#index")
    end

    it "routes to #new" do
      get("/agenda_bottoms/new").should route_to("agenda_bottoms#new")
    end

    it "routes to #show" do
      get("/agenda_bottoms/1").should route_to("agenda_bottoms#show", :id => "1")
    end

    it "routes to #edit" do
      get("/agenda_bottoms/1/edit").should route_to("agenda_bottoms#edit", :id => "1")
    end

    it "routes to #create" do
      post("/agenda_bottoms").should route_to("agenda_bottoms#create")
    end

    it "routes to #update" do
      put("/agenda_bottoms/1").should route_to("agenda_bottoms#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/agenda_bottoms/1").should route_to("agenda_bottoms#destroy", :id => "1")
    end

  end
end
