$('#spinner').css 'display', 'none'
$('#device_serial').val('')

$('#device_serial_field').click ->
  $('#deviceModal').modal()

$('#device_serial').keyup ->
  if $(this).val().length > 5
    $('#spinner').css 'display', 'inline'
    $.ajax
      url: "/devices/getItems.json"
      type: "get"
      dataType: "json"
      data: {keyword:$(this).val()}
      success: (data) ->
        $('#serial_filter_tb').html('');
        $.each data, (i, o) ->
          $('#serial_filter_tb').append "<tr>"+
              '<td>'+
                '<input type="radio" class="icheck" name="serial" value='+o.serial+' title='+o.id+'> '+ o.serial +
              '</td>'+
              '<td>'+
                o.dealer +
              '</td>'+
            '</tr>'
          return
        $('#spinner').css 'display', 'none'
        $('.icheck').iCheck
          checkboxClass: 'icheckbox_flat-green'
          radioClass: 'iradio_flat-green'
        return

$('#submit_serial').click ->
  if $('#serial_filter_tb input:checked').length == 1
    $('#device_serial_field').val($('#serial_filter_tb input:checked')[0].value)
    $('#device_id_field').val($('#serial_filter_tb input:checked')[0].title)
    $('#deviceModal').modal('hide')