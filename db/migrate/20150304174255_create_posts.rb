class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.string :type
      t.datetime :end_date
      t.text :download_link

      t.timestamps
    end
  end
end
