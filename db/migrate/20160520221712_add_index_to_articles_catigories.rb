class AddIndexToArticlesCatigories < ActiveRecord::Migration
  def change
    add_index(:articles_categories, [:article_id, :category_id], unique: true)
    add_index(:articles_categories, [:category_id, :article_id], unique: true)
  end
end
