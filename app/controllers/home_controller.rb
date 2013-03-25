class HomeController < ApplicationController
  def index
    @users = User.all

    # Read in all entries in order to display on home page
    @entries = Entry.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entries }
  	end
  end
end
