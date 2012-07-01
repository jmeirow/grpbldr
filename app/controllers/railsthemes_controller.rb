class RailsthemesController < ApplicationController
  # normally every view will use your application layout
  def inner
    render :layout => 'landing'
  end

  # this is a special layout for landing and home pages
  def landing
    render :layout => 'landing'
  end

  def jquery_ui
    render :layout => 'landing'
  end 
end
