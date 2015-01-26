class RemoveTitleEToTeacher < ActiveRecord::Migration
  def change
    remove_column :teachers, :title_e

  end
end
