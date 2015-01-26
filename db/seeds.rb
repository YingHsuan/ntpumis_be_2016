# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
#
puts '==================Generate Mock Datas for Teachers=================='
create_teachers = for i in 1..10 do
                    Teacher.create!([name_c:"老師 #{i}",name_e:"Teacher #{i}",office_c:"辦公室 #{i}",office_e:"Office #{i}",domain_c:"專業知識 #{i}",domain_e:"Domain #{i}",degree_c:"台北大學#{i}所博士",degree_e:"Ph.d in #{i} institute ,NTPU",image_url:"http://image#{i}.jpg",title_priority:"1",is_chair:"false",email:"test#{i}@test.com",tel:"2222333#{i}",extension:"6689#{i}",employ_type:"1"])
                  end
