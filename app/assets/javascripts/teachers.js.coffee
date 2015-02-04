# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

Teacher = require './service/teacher'
Thesis = require './service/thesis'
$(document).on 'ready', ->
  $('#loading').hide()
  console.log Teacher
