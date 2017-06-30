class AddAttachmentPhotoToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.attachment :photo
    end
  end
end
