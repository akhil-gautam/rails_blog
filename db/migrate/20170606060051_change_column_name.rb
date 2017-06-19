class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :comments, :commenter, :name
  end
end
