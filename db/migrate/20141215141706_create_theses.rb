class CreateTheses < ActiveRecord::Migration
  def change
    create_table :theses do |t|
      t.string :name_c
      t.string :name_e
      t.integer :student_id
      t.integer :teacher_id
      t.integer :year

      t.timestamps
    end
  end
end
