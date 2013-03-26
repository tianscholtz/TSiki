module EntriesHelper

	def save_revision(entry)
    	if user_signed_in?
      		Revision.create(:title => entry.title , :body => entry.body, :entry => entry, :editor => current_user.name, :user => current_user)
    	else
      		Revision.create(:title => entry.title , :body => entry.body, :entry => entry, :editor => current_user.name)
    	end
  	end

end
