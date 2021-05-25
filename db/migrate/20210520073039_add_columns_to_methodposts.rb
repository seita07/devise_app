class AddColumnsToMethodposts < ActiveRecord::Migration[6.1]
  def change
    add_column :methodposts, :subjects, :string
  end
end
