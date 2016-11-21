class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :routine_id
      t.text :body
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :comments, :routine_id
  end
end
