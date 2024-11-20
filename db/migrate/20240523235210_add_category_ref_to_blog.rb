class AddCategoryRefToBlog < ActiveRecord::Migration[7.1]
  def change
    add_reference :blogs, :category, foreign_key: true
  end
end
