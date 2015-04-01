class ChangeColumnForTableEvent < ActiveRecord::Migration
  def change
    change_column :events, :id, :string
  end
end
