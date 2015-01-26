#console.log 'thesis'
API_HOST = '//localhost:8080/'
class Thesis
  getThesisList:(type='thesis')->
    list = {}
    data =
      "thesis_type":type
    $.ajax
      async:false
      type:'POST'
      url:API_HOST+'thesis/list'
      dataType:'json'
      data:JSON.stringify data
    .done((result)->
      list = result
    )

    list

  createThesis:(obj)->
    result={}
    $.ajax
      async:false
      type:'POST'
      url:API_HOST+'thesis/create'
      dataType:'json'
      data:JSON.stringify obj
    .done((res)->
      result = res
    )

    result
module.exports = new Thesis()
