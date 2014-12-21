class RenameColumnToTeachers < ActiveRecord::Migration
  def change
    rename_column :teachers, :extention, :extension

  end
end
