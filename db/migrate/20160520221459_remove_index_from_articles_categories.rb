class RemoveIndexFromArticlesCategories < ActiveRecord::Migration
  def change
    remove_index :articles_categories, ["article_id", "category_id"]
    remove_index :articles_categories, ["category_id", "article_id"]
  end
end
