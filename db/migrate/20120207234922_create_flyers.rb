class CreateFlyers < ActiveRecord::Migration
  def self.up
    create_table :flyers do |t|
      t.string :name
      t.integer :store_id
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end

  def self.down
    drop_table :flyers
  end
end
