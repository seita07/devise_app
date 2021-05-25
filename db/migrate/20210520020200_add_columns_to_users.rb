class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :gender, :string
    add_column :users, :birth_date, :date
    add_column :users, :prefectures, :string
    add_column :users, :occupation, :string
    add_column :users, :target_school, :string
    add_column :users, :comment, :text
  end
end
