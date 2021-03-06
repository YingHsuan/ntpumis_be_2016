class ThesesController < ApplicationController

  require 'ntpumis_logger'

  before_action :authenticate_user!, only: [:new, :index, :show, :edit, :create, :update, :destroy]
  before_action :find_thesis, only:[:edit,:update, :show, :destroy]
  def index
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @theses = Thesis.where("conference =''")
    @publications = Thesis.where("conference <> ''")
  end

  def new
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @thesis = Thesis.new
    @students_current = Student.where("is_graduated = ?",false).order(grade: :desc)
    @students_graduated = Student.where("is_graduated = ?",true).order(grade: :desc)
  end

  def edit
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @students_current = Student.where("is_graduated = ?",false).order(grade: :desc)
    @students_graduated = Student.where("is_graduated = ?",true).order(grade: :desc)
    @student_name = Student.find_by_id(@thesis.student_id).stu_name
  end
  def create
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @thesis = Thesis.new(thesis_params)
    @thesis.save

    redirect_to :action => :index
    flash[:notice] = "成功新增論文 #{@thesis.name}"

  end
  def update
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @thesis.update(thesis_params)

    redirect_to :action => :show, :id => @thesis
    flash[:notice] = "成功更新論文 #{@thesis.name}"
  end
  def show
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @student_name = Student.find_by_id(@thesis.student_id).stu_name
    @supervisor1 = Teacher.find_by_id(@thesis.supervisor1).name_c
    @supervisor2 = Teacher.find_by_id(@thesis.supervisor2).nil? ? "" : Teacher.find_by_id(@thesis.supervisor2)
  end
  def destroy
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @thesis.destroy
    redirect_to :action => :index
    flash[:alert] = "成功刪除論文 #{@thesis.name}"
  end


  def list

    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    data = JSON.parse(request.body.read)
    puts data
    result = Array.new
    if data['thesis_type'] == "thesis"
      theses = Thesis.where("conference =''")
    elsif data['thesis_type'] == "publication"
      theses = Thesis.where("conference <> ''")
    else
      theses = Thesis.all
    end
    theses.each do |thesis|
      teacher = Teacher.where(:id =>thesis.supervisor1).select(:name_c).first
      teacher2 = Teacher.where(:id =>thesis.supervisor2).select(:name_c).first
      student = Student.where(:id =>thesis.student_id).select(:stu_name).first
      result.push(
          {
            :id => thesis.id,
            :name => thesis.name,
            :year => thesis.year,
            :student_id => student.stu_name,
            :teacher_name => "#{teacher.name_c} #{teacher2.nil? ? "" : teacher2.name_c}",
            :conference => thesis.conference

          }
        )
    end


    render :json => result

  end

  def create_api
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    data = JSON.parse(request.body.read)
    puts data.to_s

    thesis = Thesis.new
    thesis.transaction do
      thesis.name = data['name']
      thesis.year = data['year']
      thesis.student_id = data['student_id']
      thesis.supervisor1 = data['supervisor1']
      thesis.conference = data['conference']
      thesis.save!
    end
    result =
      {
       :status => 'success',
       :id => thesis.id,
       :createTime => thesis.created_at
      }
    render :json => result
  end

  def detail
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    thesis = Thesis.find_by_id(params[:thesisId])
    teacher = Teacher.where(:id =>thesis.supervisor1).select(:name_c).first
    student = Student.where(:id =>thesis.student_id).select(:stu_name).first
    if thesis.nil?
      render :json => {
                  :error => 'Bad request'
              },
             :status => 400
    else
      data = {
            :id => thesis.id,
            :name => thesis.name,
            :year => thesis.year,
            :student_name => student.stu_name,
            :teacher_name => teacher.name_c,
            :conference => thesis.conference
      }

      render :json => data
    end
  end

  def update_api
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    thesis = Thesis.find_by_id(params[:thesisId])
    if thesis.nil?
      render :json => {
                  :error => 'Bad request'
              },
             :status => 400
    else
      data = JSON.parse(request.body.read)
      puts data.to_s

      thesis.name = data['name']
      thesis.year = data['year']
      thesis.student_id = data['student_id']
      thesis.supervisor1 = data['supervisor1']
      thesis.conference = data['conference']
      thesis.save!

      render :json =>{
        :id => thesis.id,
        :status => 'successfully updated'
      }
    end
  end
  def delete
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    thesis = Thesis.find_by_id(params[:thesisId])
    if thesis.nil?
      render :json => {
                  :error => 'Bad request'
              },
             :status => 400
    else
      puts "Thesis_ id :#{thesis.id} DELETED"
      thesis.destroy
      render :json =>{
        :status => "success"
      }
    end
  end
  private
  def thesis_params
    params.require(:thesis).permit(:name,:student_id, :year, :supervisor1, :supervisor2,:conference)
  end
  def find_thesis
    @thesis = Thesis.find(params[:id])
  end

end




