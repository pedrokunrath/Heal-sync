class AddMetaToBlog < ActiveRecord::Migration[7.1]
  def change
    add_column :blogs, :meta, :text
  end
end
