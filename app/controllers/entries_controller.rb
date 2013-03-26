class EntriesController < ApplicationController
  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.all


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entries }
    end
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    @entry = Entry.find(params[:id])
    @revisions = Revision.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @entry }
    end
  end

  # GET /entries/new
  # GET /entries/new.json
  def new
    @entry = Entry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @entry }
    end
  end

  # GET /entries/1/edit
  def edit
    @entry = Entry.find(params[:id])
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(params[:entry])

    @entry.user = current_user

    respond_to do |format|
      if @entry.save
        format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
        format.json { render json: @entry, status: :created, location: @entry }
        # Save a copy of the new file
        Revision.create(:title => @entry.title , :body => @entry.body, :entry => @entry, :editor => current_user.name, :user => current_user)
      else
        format.html { render action: "new" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /entries/1R
  # PUT /entries/1.json
  def update
    @entry = Entry.find(params[:id])

    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { head :no_content }
        # Save a copy of the update
        if user_signed_in?
          Revision.create(:title => @entry.title , :body => @entry.body, :entry => @entry, :editor => current_user.name, :user => current_user)
        else
          Revision.create(:title => @entry.title , :body => @entry.body, :entry => @entry, :editor => "Anonymous")
        end
      else
        format.html { render action: "edit" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry = Entry.find(params[:id])
    #@entry.destroy

    # Only delete entry if entry belongs to current user or current user is an admin
    respond_to do |format|
      if @entry.user == current_user or current_user.has_role? :admin

        # Delete all revisions of an entry before deleting entry
        @revisions = @entry.revisions
        for revision in @revisions
          revision.destroy
        end
        
        if @entry.destroy
          format.html { redirect_to entries_url, notice: 'Entry was successfully deleted.' }
          format.json { head :no_content }
        end
      else
        
      end
    end

    #respond_to do |format|
    #  format.html { redirect_to entries_url }
    #  format.json { head :no_content }
    #end
  end
end
