# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$('#loader').css 'display', 'none'
update = ->
  $('#loader').css 'display', ''
  $.ajax
    url: '/log/update_data'
    success: (data) ->
      $('#log_content').html data
      $('#loader').css 'display', 'none'
      setTimeout update, 5000
      return

setTimeout update, 5000
