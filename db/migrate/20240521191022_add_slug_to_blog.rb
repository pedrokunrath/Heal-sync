class AddSlugToBlog < ActiveRecord::Migration[7.1]
  def change
    add_column :blogs, :slug, :text
  end
end
