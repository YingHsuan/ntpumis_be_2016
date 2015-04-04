# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready', ->
  $('#post_end_date').val($('#post_end_date').val().substr(0,10))
  $('#post_end_date').datepicker
    language: 'zh-TW'
    format: 'yyyy/mm/dd'
    autoclose: true
    startDate:new Date()
    clearBtn : true
  $('#post_end_date').on 'click', ->
    $(@).blur()
  $('table').dataTable()



