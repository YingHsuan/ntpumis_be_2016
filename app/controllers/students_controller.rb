class StudentsController < ApplicationController
  def index
    @students = Student.all
  end





  private
  def student_params
    params.require(:student).permit(:stu_no,:stu_name,:grade,:gender,:address,:tel,:mobile,:email,:supervisor1,:supervisor2,:is_graduated,:job_organization,:job_title,:job_industry)
  end
end
