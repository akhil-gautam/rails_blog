class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  validates :name, :presence => true, :length => { :minimum => 5 }
  validates :body, :presence => true, :length => { :minimum => 1 }
end
