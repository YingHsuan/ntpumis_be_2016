class ThesesController < ApplicationController

  require 'ntpumis_logger'
  before_action :find_thesis, only:[:edit,:update, :show, :destroy]
  def index
    @theses = Thesis.where("conference =''")
    @publications = Thesis.where("conference <> ''")
  end

  def new
    @thesis = Thesis.new
    @students_current = Student.where("is_graduated = ?",false).order(grade: :desc)
    @students_graduated = Student.where("is_graduated = ?",true).order(grade: :desc)
  end

  def edit
    @students_current = Student.where("is_graduated = ?",false).order(grade: :desc)
    @students_graduated = Student.where("is_graduated = ?",true).order(grade: :desc)

  end
  def create
    @thesis = Thesis.new(thesis_params)
    @thesis.save

    redirect_to :action => :index
    flash[:notice] = "成功新增論文 #{@thesis.name}"

  end
  def update
    @thesis.update(thesis_params)

    redirect_to :action => :show, :id => @thesis
    flash[:notice] = "成功更新論文 #{@thesis.name}"
  end
  def show
  end
  def destroy
    @thesis.destroy
    redirect_to :action => :index
    flash[:alert] = "成功刪除論文 #{@thesis.name}"
  end


  def list

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
      teacher = Teacher.where(:id =>thesis.teacher_id).select(:name_c).first
      student = Student.where(:id =>thesis.student_id).select(:stu_name).first
      result.push(
          {
            :id => thesis.id,
            :name => thesis.name,
            :year => thesis.year,
            :student_id => student.stu_name,
            :teacher_name => teacher.name_c,
            :conference => thesis.conference

          }
        )
    end


    render :json => result

  end

  def create_api
    data = JSON.parse(request.body.read)
    puts data.to_s

    thesis = Thesis.new
    thesis.transaction do
      thesis.name = data['name']
      thesis.year = data['year']
      thesis.student_id = data['student_id']
      thesis.teacher_id = data['teacher_id']
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
    thesis = Thesis.find_by_id(params[:thesisId])
    teacher = Teacher.where(:id =>thesis.teacher_id).select(:name_c).first
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
      thesis.teacher_id = data['teacher_id']
      thesis.conference = data['conference']
      thesis.save!

      render :json =>{
        :id => thesis.id,
        :status => 'successfully updated'
      }
    end
  end
  def delete
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
    params.require(:thesis).permit(:name,:student_id, :year, :teacher_id,:conference)
  end
  def find_thesis
    @thesis = Thesis.find(params[:id])
  end

end




