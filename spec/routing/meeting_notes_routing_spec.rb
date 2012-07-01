require "spec_helper"

describe MeetingNotesController do
  describe "routing" do

    it "routes to #index" do
      get("/meeting_notes").should route_to("meeting_notes#index")
    end

    it "routes to #new" do
      get("/meeting_notes/new").should route_to("meeting_notes#new")
    end

    it "routes to #show" do
      get("/meeting_notes/1").should route_to("meeting_notes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/meeting_notes/1/edit").should route_to("meeting_notes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/meeting_notes").should route_to("meeting_notes#create")
    end

    it "routes to #update" do
      put("/meeting_notes/1").should route_to("meeting_notes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/meeting_notes/1").should route_to("meeting_notes#destroy", :id => "1")
    end

  end
end
