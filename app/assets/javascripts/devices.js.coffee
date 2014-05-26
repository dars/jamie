# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$('#serialNumber').blur ->
  if($(this).val().length != 8)
    $('#serialNumber-form-group').addClass('has-error')
    $('#serialNumber-help-block').html('序號長度不正確')
  else
    $('#serialNumber-form-group').removeClass('has-error')
    $('#serialNumber-help-block').html('')
    return

$('#start_date').blur ->
  sdate = $(this).val()
  if($('#type_combobox').val() == '1')
    $('#end_date').val moment(sdate).add('y', 1).format('YYYY-MM-DD')
  else
    $('#end_date').val moment(sdate).add('M', 1).format('YYYY-MM-DD')
  return