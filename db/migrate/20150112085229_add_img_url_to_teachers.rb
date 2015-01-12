class AddImgUrlToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :image_url, :text
  end
end
