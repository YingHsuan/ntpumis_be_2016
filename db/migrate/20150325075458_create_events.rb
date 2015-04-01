class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :content
      t.datetime :start_time
      t.datetime :end_time
      t.string :type
      t.string :location

      t.timestamps
    end
  end
end
