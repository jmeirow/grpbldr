require "spec_helper"

describe AgendaDefinitionsController do
  describe "routing" do

    it "routes to #index" do
      get("/agenda_definitions").should route_to("agenda_definitions#index")
    end

    it "routes to #new" do
      get("/agenda_definitions/new").should route_to("agenda_definitions#new")
    end

    it "routes to #show" do
      get("/agenda_definitions/1").should route_to("agenda_definitions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/agenda_definitions/1/edit").should route_to("agenda_definitions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/agenda_definitions").should route_to("agenda_definitions#create")
    end

    it "routes to #update" do
      put("/agenda_definitions/1").should route_to("agenda_definitions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/agenda_definitions/1").should route_to("agenda_definitions#destroy", :id => "1")
    end

  end
end
