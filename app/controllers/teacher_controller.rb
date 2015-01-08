class TeacherController < ApplicationController
  def index
    @teachers = Teacher.all
  end
  def show
  end
  def new
    @teacher = Teacher.new
  end
  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
  

# API
  def list
    data = JSON.parse(request.body.read)
    result = Array.new
    teachers = Teacher.all
    teachers.each do |teacher|
      if data['locale'] == 'en' 
        result.push(
            {
              :id => teacher.id,
              :name => teacher.name_e,
              :office => teacher.office_e,
              :domain => teacher.domain_e,
              :degree => teacher.degree_e,
              :title => teacher.title_e,
              :title_priority => teacher.title_priority,
              :is_chair => teacher.is_chair,
              :email => teacher.email,
              :tel => teacher.tel,
              :extension => teacher.extension,
              :employ_type => teacher.employ_type

            }
          )
      else
        result.push(
            {
              :id => teacher.id,
              :name => teacher.name_c,
              :office => teacher.office_c,
              :domain => teacher.domain_c,
              :degree => teacher.degree_c,
              :title => teacher.title_c,
              :title_priority => teacher.title_priority,
              :is_chair => teacher.is_chair,
              :email => teacher.email,
              :tel => teacher.tel,
              :extension => teacher.extension,
              :employ_type => teacher.employ_type

            }
          )
      end
    end
    render :json => result

  end

  def create_api
    data = JSON.parse(request.body.read)
    puts data.to_s

    teacher = Teacher.new
    teacher.transaction do
      teacher.name_c = data['name_c']
      teacher.name_e = data['name_e']
      teacher.office_c = data['office_c']
      teacher.office_e = data['office_e']
      teacher.domain_c = data['domain_c']
      teacher.domain_e = data['domain_e']
      teacher.degree_c = data['degree_c']
      teacher.degree_e = data['degree_e']
      teacher.title_c = data['title_c']
      teacher.title_e = data['title_e']
      teacher.title_priority = data['title_priority']
      teacher.is_chair = data['is_chair']
      teacher.email = data['email']
      teacher.tel = data['tel']
      teacher.extension = data['extension']
      teacher.employ_type = data['employ_type']
      teacher.save!   
    end
    result = 
      {
       :status => 'success',
       :id => teacher.id,
       :createTime => teacher.created_at
      }
    render :json => result
  end

  def update_api
    teacher = Teacher.find_by_id(params[:teacherId])
    if teacher.nil?
      render :json => {
                  :error => 'Bad request'
              },
             :status => 400
    else
      data = JSON.parse(request.body.read)
      puts data.to_s

      teacher.name_c = data['name_c']
      teacher.name_e = data['name_e']
      teacher.office_c = data['office_c']
      teacher.office_e = data['office_e']
      teacher.domain_c = data['domain_c']
      teacher.domain_e = data['domain_e']
      teacher.degree_c = data['degree_c']
      teacher.degree_e = data['degree_e']
      teacher.title_c = data['title_c']
      teacher.title_e = data['title_e']
      teacher.title_priority = data['title_priority']
      teacher.is_chair = data['is_chair']
      teacher.email = data['email']
      teacher.tel = data['tel']
      teacher.extension = data['extension']
      teacher.employ_type = data['employ_type']
      teacher.save!   
      
      render :json =>{
        :id => teacher.id,
        :status => 'successfully updated'
      }
    end
  end
  def delete
    teacher = Teacher.find_by_id(params[:teacherId])
    if teacher.nil?
      render :json => {
                  :error => 'Bad request'
              },
             :status => 400
    else
      puts "Teacher id :#{teacher.id} DELETED"
      teacher.destroy
      render :json =>{
        :status => "success"
      }
    end
  end

end
