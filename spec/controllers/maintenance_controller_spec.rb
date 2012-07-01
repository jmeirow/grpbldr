require 'spec_helper'

describe MaintenanceController do

  describe "GET 'display_message'" do
    it "returns http success" do
      get 'display_message'
      response.should be_success
    end
  end

end
