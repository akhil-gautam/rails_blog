require 'elasticsearch/model'

class Comment < ActiveRecord::Base

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  belongs_to :article
  belongs_to :user
  validates :body, :presence => true, :length => { :minimum => 1, :maximum => 275 }
end
