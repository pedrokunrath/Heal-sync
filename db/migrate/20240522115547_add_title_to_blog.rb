class AddTitleToBlog < ActiveRecord::Migration[7.1]
  def change
    add_column :blogs, :title, :text
  end
end
