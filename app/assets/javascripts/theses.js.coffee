# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready', ->
  $('#student_name').on 'focus', ->
    $(@).blur()
  $('#studentBtn').on 'click', ->
    $('#studentModal').modal()

  $('.studentConfirmBtn').on 'click', ->
    studentArr = $(@).val().split(" ")
    $('#thesis_student_id').val(studentArr[0])
    $('#student_name').val(studentArr[1])
    $('#studentModal').modal('hide')

  $('.studentTable').dataTable()
  $('#thesisTable,#publicationTable').dataTable()
