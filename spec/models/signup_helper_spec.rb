require 'spec_helper'
 

 

describe SignupHelper do



  # context "Passing a String to 'user_has_submitted_request?'" do

  
  #   it "should raise an Error" do
  #     SignupHelper.user_has_submitted_request?(' ').should raise_error(ArgumentError)
  #   end
  # end


  context "Passing an empty Hash to 'user_has_submitted_request?'" do

    before(:all) do 
      @params = Hash.new
    end
  
    it "should return false" do
      SignupHelper.user_has_submitted_request?(@params).should be_false
    end
  end








  context "Submitting with no changes seleted should produce an error'" do

    before(:all) do 
      @params = Hash.new
      @params[:commit] = 'Submit'
    end

    it "should return false" do
      if SignupHelper.user_has_submitted_request? @params
        helper = SignupHelper.new @params
        helper.validate?.should be_false
        helper.errors.count.should be > 0
      end
    end
  end






  context "when form is submitted and User has clicked the submit button... " do

    before(:all) do 
      @params = Hash.new
      @params[:commit] = 'Submit'
    end
  
    it "then method 'user_has_submitted_request? should return true" do
      SignupHelper.user_has_submitted_request?(@params).should be_true
    end
  
  end
  



  






  
  context "when form is submitted and User has clicked the submit button and has selected 'signup' on some meetings... " do

    before(:all) do 
      @params = Hash.new
      @params[:commit] = 'Submit'
      @params[:signup_ids] = ["109_42", "108_41"]
      @params[:club_id] = '8'
      @params[:member_id] = '61'
    end
  
  
    it "should return 42" do
      results = SignupHelper.role_ids_from_signups(@params)
      results.include?("42").should be_true
    end

    it "should return 41" do
      results = SignupHelper.role_ids_from_signups(@params)
      results.include?("41").should be_true
    end

    it "return array should have count of 2" do
      results = SignupHelper.role_ids_from_signups(@params)
      results.count.should == 2
    end


    it "class method roles should return an Array " do
      roles = SignupHelper.roles @params
      roles.should be_an_instance_of(Array)
    end
      
    it "should return an array of Role models " do
      roles = SignupHelper.roles @params
      roles.each do | role |
        role.should be_an_instance_of(Role)
      end
    end

    it "should return an array of Role models only for the current club " do
      club_id = @params[:club_id].to_i
      roles = SignupHelper.roles @params
      roles.each do | role |
        role.club_id.should be club_id 
      end
    end
  end
  
  
  



  
  
  context "when form is submitted to select.onchange event submitting the form... " do

    before(:all) do 
      @params = Hash.new
    end
  
    it "then method 'user_has_submitted_request? should return false" do
      SignupHelper.user_has_submitted_request?(@params).should be_false
    end
  
  end   




    
 
  context "when instance methods are called" do

    before(:all) do 
      @params = Hash.new
      @params[:some_key] = "some value"
    end
  
    it "params hash should have something in it" do
      @params.count.should be > 0
    end

  end



end
