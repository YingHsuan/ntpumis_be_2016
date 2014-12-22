class ThesisController < ApplicationController

  require 'ntpumis_logger'

  def index
    @theses = Thesis.all
  end

  def list

    # data = JSON.parse(request.body.read)
    result = Array.new
    theses = Thesis.all
    theses.each do |thesis|
      result.push(
          {
            :id => thesis.id,
            :name_c => thesis.name_c,
            :name_e => thesis.name_e,
            :year => thesis.year,
            :student_id => thesis.student_id,
            :teacher_id => thesis.teacher_id,
            :conference => thesis.conference

          }
        )
    end
    
    puts result.to_s
    render :json => result
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
    if thesis.nil?
      render :json => {
                  :error => 'Bad request'
              },
             :status => 400
    else
      thesis = Thesis.find_by_id(params[:thesisId])
      data = {
            :id => thesis.id,
            :name_c => thesis.name_c,
            :name_e => thesis.name_e,
            :year => thesis.year,
            :student_id => thesis.student_id,
            :teacher_id => thesis.teacher_id,
            :conference => thesis.conference
      }

      render :json => data
    end
  end
end




