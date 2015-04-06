class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.string :file_type
      t.string :title
      t.string :link

      t.timestamps
    end
  end
end
