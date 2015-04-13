$(document).on 'ready', ->
  $('#event_start_time').datetimepicker(
    format:'YYYY-MM-DD HH:mm'
  )
  $('#event_end_time').datetimepicker(
    format:'YYYY-MM-DD HH:mm'
  )
  $('#event_start_time').on 'dp.change', (e) ->
    $('#event_end_time').data('DateTimePicker').minDate e.date
  $('#event_end_time').on 'dp.change', (e) ->
    $('#event_start_time').data('DateTimePicker').maxDate e.date
