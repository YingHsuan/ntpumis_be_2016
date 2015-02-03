class StudentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :index, :show, :edit, :create, :update, :destroy]
  before_action :find_student, only:[:edit, :show, :update, :destroy]

  JOB_INDUSTRY = {
    :A => "農、林、漁、牧業",
    :B => "礦業及土石採取業",
    :C => "製造業",
    :D => "電力及燃氣供應業",
    :E => "用水供應及污染整治業",
    :F => "營造業",
    :G => "批發及零售業",
    :H => "運輸及倉儲業",
    :I => "住宿及餐飲業",
    :J => "資訊及通訊傳播業",
    :K => "金融及保險業",
    :L => "不動產業",
    :M => "專業、科學及技術服務業",
    :N => "支援服務業",
    :O => "公共行政及國防；強制性社會安全",
    :P => "教育服務業",
    :Q => "醫療保健及社會工作服務業",
    :R => "藝術、娛樂及休閒服務業",
    :S => "其他服務業"

  }
  def index
    @students_current = Student.where("is_graduated = ?",false).order(grade: :desc)
    @students_graduated = Student.where("is_graduated = ?",true).order(grade: :desc)
  end
  def new
    @job_industry = JSON.parse(JSON[JOB_INDUSTRY])
    @student = Student.new
  end
  def create
    @student = Student.new(student_params)
    @student.save

    redirect_to :action => :index
    flash[:notice] = "成功新增學生 #{@student.stu_name}"
  end
  def edit
    @job_industry = JSON.parse(JSON[JOB_INDUSTRY])

  end
  def update
    @student.update(student_params)

    redirect_to :action => :show, :id => @student
    flash[:notice] = "成功更新學生 #{@student.stu_name}"
  end
  def show
    @job_industry = JSON.parse(JSON[JOB_INDUSTRY])
  end
  def destroy
    @student.destroy
    redirect_to :action => :index
    flash[:alert] = "成功刪除學生 #{@student.stu_name}"
  end

  private
  def student_params
    params.require(:student).permit(:stu_no,:stu_name,:grade,:gender,:address,:tel,:mobile,:email,:supervisor1,:supervisor2,:is_graduated,:job_organization,:job_title,:job_industry)
  end
  def find_student
    @student = Student.find(params[:id])
  end
end
