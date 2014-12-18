class ThesisController < ApplicationController
  def index
    @theses = Thesis.all
  end

  def list
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
            :teacher_id => thesis.teacher_id

          }
        )
    end
    render :json => result
  end



end




