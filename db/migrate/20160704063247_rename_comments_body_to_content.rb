class RenameCommentsBodyToContent < ActiveRecord::Migration
  def change
    rename_column :comments, :body, :content
  end
end
