class Thesis < ActiveRecord::Base
  validates_presence_of :name_c, :name_e, :student_id, :teacher_id, :year
end
