class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      # just one name
      t.string :name, null: false, index: { unique: true }
      t.text :description

      t.timestamps
    end
  end
end
