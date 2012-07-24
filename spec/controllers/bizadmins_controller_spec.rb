require 'spec_helper'

describe BizadminsController do

  describe "GET 'blank'" do
    it "returns http success" do
      get 'blank'
      response.should be_success
    end
  end

end
