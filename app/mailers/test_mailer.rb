class TestMailer < ActionMailer::Base
  def test (dist_list)
    mail(:to => dist_list, :subject => "Test", :from => "noreply@groupbuilderplus.com" )  
  end
end