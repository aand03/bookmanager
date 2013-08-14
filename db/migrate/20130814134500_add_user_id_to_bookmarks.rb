class AddUserIdToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :user_id, :string
  end
end
