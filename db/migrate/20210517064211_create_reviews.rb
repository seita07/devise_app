class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :user, foreign_key: true
      t.references :methodpost, foreign_key: true
      t.text :text, null: false
      t.float :evaluation, null: false

      t.timestamps
    end
  end
end
