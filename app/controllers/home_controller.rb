class HomeController < ApplicationController
  def index
    @club = Club.find(1)
  end

end
