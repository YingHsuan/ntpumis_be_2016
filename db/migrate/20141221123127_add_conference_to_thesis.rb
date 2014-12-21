class AddConferenceToThesis < ActiveRecord::Migration
  def change
    add_column :theses, :conference, :string
  end
end
