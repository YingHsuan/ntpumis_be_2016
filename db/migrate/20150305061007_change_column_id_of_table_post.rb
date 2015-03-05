class ChangeColumnIdOfTablePost < ActiveRecord::Migration
  def change
    change_column :posts, :id, :string
  end
end
