class AddImageToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :image, foreign_key: true
  end
end
