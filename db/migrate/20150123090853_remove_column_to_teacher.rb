class RemoveColumnToTeacher < ActiveRecord::Migration
  def change
    remove_column :teachers, :title_c, :title_e
  end
end
