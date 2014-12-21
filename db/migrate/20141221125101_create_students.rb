class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :stu_no
      t.string :stu_name
      t.integer :grade
      t.integer :gender
      t.string :address
      t.string :tel
      t.string :mobile
      t.string :email
      t.integer :supervisor1
      t.integer :supervisor2
      t.boolean :is_graduated
      t.string :job_organization
      t.string :job_title
      t.string :job_industry

      t.timestamps
    end
  end
end
