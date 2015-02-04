class AddColumnToTheses < ActiveRecord::Migration
  def change
    rename_column :theses ,:teacher_id, :supervisor1
    add_column :theses, :supervisor2, :integer
  end
end
