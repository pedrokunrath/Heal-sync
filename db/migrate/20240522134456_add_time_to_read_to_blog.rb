class AddTimeToReadToBlog < ActiveRecord::Migration[7.1]
  def change
    add_column :blogs, :time_to_read, :integer
  end
end
