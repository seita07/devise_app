class CreateMethodLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :method_likes do |t|
      t.references :user, foreign_key: true
      t.references :methodpost, foreign_key: true

      t.timestamps
    end
  end
end
