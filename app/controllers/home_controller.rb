class HomeController < ApplicationController
  def index
    @users = User.all
    @entries = Entry.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entries }
  	end
  end
end
