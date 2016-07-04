class AddAuthorToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :author, index: true
    add_foreign_key :comments, :users, column: :author_id
  end
end
