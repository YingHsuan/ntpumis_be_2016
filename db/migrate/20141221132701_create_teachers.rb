class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :name_c
      t.string :name_e
      t.string :office_c
      t.string :office_e
      t.text :domain_c
      t.text :domain_e
      t.string :degree_c
      t.string :degree_e
      t.string :title_c
      t.string :title_e
      t.integer :title_priority 
      t.boolean :is_chair
      t.string :email
      t.string :tel
      t.string :extention
      t.integer :employ_type


      t.timestamps
    end
  end
end
