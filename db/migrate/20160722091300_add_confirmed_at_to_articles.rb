class AddConfirmedAtToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :confirmed_at, :timestamp
  end
end
