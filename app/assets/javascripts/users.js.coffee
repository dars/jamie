# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('#role_combobox').change ->
  if $(this).val() is 'user'
    $('#license_div').css('display', 'block')
  else
    $('#license_div').css('display', 'none')
  return