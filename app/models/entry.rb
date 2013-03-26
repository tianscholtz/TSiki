class Entry < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :title, :user_id

  validates :body, :title, :presence => true

  has_many :revisions

end
