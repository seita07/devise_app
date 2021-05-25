class CreateTimeLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :time_likes do |t|
      t.references :user, foreign_key: true
      t.references :timepost, foreign_key: true

      t.timestamps
    end
  end
end
