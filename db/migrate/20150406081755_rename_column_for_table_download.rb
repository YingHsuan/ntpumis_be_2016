class RenameColumnForTableDownload < ActiveRecord::Migration
  def change
  	change_column :downloads, :id, :string
  end
end
