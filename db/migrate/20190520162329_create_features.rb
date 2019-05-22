class CreateFeatures < ActiveRecord::Migration[5.2]
  def change
    create_table :features do |t|
      t.string :feature_id
      t.float :mag
      t.string :place
      t.time :time
      t.string :url
      t.integer :tsunami
      t.string :mag_type
      t.string :title
      t.json :coordinates

      t.timestamps
    end
    add_index :features, :feature_id, unique: true
  end
end
