class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :title
      t.string :address
      t.string :city
      t.string :state
      t.text :description
      t.date :date_posted

      t.timestamps
    end
  end
end
