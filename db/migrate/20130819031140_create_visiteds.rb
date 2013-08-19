class CreateVisiteds < ActiveRecord::Migration
  def change
    create_table :visiteds do |t|
      t.integer :user_id
      t.integer :location_id

      t.timestamps
    end
  end
end
