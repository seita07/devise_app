class CreateTimeposts < ActiveRecord::Migration[6.1]
  def change
    create_table :timeposts do |t|
      t.text :content
      t.integer :time
      t.integer :user_id

      t.timestamps
    end
    add_index :timeposts, %i[user_id created_at]
  end
end
