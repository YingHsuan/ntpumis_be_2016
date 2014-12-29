class ThesisController < ApplicationController

  require 'ntpumis_logger'

  def index
    @theses = Thesis.all
  end

  def list
    if (request.body.read) == ""
      render :json => {
        "status" =>"bad request"
      }
    else
      data = JSON.parse(request.body.read)
      result = Array.new
      if data['type'] == "thesis"
        theses = Thesis.where("conference is null")
      elsif data['type'] == "publication"
        theses = Thesis.where("conference is not null")
      else
        theses = Thesis.all
      end
      theses.each do |thesis|
        
        teacher = Teacher.where(:id =>thesis.teacher_id).select(:name_c).first
        student = Student.where(:id =>thesis.student_id).select(:stu_name).first
        result.push(
            {
              :id => thesis.id,
              :name_c => thesis.name_c,
              :name_e => thesis.name_e,
              :year => thesis.year,
              :student_id => student.stu_name,
              :teacher_name => teacher.name_c,
              :conference => thesis.conference

            }
          )
      end
      
    render :json => result
    end
    
  end

  def create
    data = JSON.parse(request.body.read)
    puts data.to_s

    thesis = Thesis.new
    thesis.transaction do
      thesis.name_c = data['name_c']
      thesis.name_e = data['name_e']
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
            :name_c => thesis.name_c,
            :name_e => thesis.name_e,
            :year => thesis.year,
            :student_name => student.stu_name,
            :teacher_name => teacher.name_c,
            :conference => thesis.conference
      }

      render :json => data
    end
  end

  def update
    thesis = Thesis.find_by_id(params[:thesisId])
    if thesis.nil?
      render :json => {
                  :error => 'Bad request'
              },
             :status => 400
    else
      data = JSON.parse(request.body.read)
      puts data.to_s

      thesis.name_c = data['name_c']
      thesis.name_e = data['name_e']
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


end




