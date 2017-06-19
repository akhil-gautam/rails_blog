class ChangeColumnNameOfArticle < ActiveRecord::Migration
  def change
  	rename_column :articles, :text, :article
  end
end
