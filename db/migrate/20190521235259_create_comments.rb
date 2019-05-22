class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :email
      t.text :body
      t.string :feature_id

      t.timestamps
    end
  end
end
