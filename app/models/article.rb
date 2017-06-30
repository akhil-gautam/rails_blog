require 'elasticsearch/model'

class Article < ActiveRecord::Base

    include Elasticsearch::Model
  	include Elasticsearch::Model::Callbacks

	has_many :comments, dependent: :destroy
	validates :title, :presence => true, :uniqueness => true,
            :length => { :minimum => 5, :maximum => 90 }
    validates :article, :presence => true, 
    		:length => { :minimum => 10, :maximum => 1024 }
    belongs_to :user
end

Article.import

