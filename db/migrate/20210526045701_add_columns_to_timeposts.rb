class AddColumnsToTimeposts < ActiveRecord::Migration[6.1]
  def change
    add_column :timeposts, :subjects, :string
    add_column :timeposts, :minitus, :integer
    add_column :timeposts, :img, :string
    add_column :timeposts, :studytime, :integer
    add_column :timeposts, :datetime, :datetime
  end
end
