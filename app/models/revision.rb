class Revision < ActiveRecord::Base
  belongs_to :entry
  belongs_to :user
  attr_accessible :body, :editor, :title, :entry, :user

  validates :body, :title, :editor, :presence => true
end
