class CreatePaintings < ActiveRecord::Migration[5.2]
  def change
    create_table :paintings do |t|
      t.string :name
      t.belongs_to :user, foreign_key: true
      t.boolean :privacy

      t.timestamps
    end
  end
end
