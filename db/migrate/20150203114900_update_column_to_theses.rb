class UpdateColumnToTheses < ActiveRecord::Migration
  def change
    rename_column :theses, :name_c, :name
    remove_column :theses, :name_e
  end
end
