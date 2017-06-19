class Article < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	validates :title, :presence => true, :uniqueness => true,
            :length => { :minimum => 5, :maximum => 10 }
    validates :article, :presence => true, 
    		:length => { :minimum => 10, :maximum => 140 }
    belongs_to :user
end