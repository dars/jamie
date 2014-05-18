# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
singers = new Bloodhound(
  datumTokenizer: Bloodhound.tokenizers.obj.whitespace("value")
  queryTokenizer: Bloodhound.tokenizers.whitespace
  remote: '/singers/get.json?keyword=%QUERY'
)

singers.initialize()

$('#singer1name, #singer2name').typeahead( null,
  name: 'singer-suggest'
  displayKey: 'SingerNameT'
  source: singers.ttAdapter()
).bind "typeahead:selected", (obj, datum, name) ->
  $('#'+$(this).attr('id').substr(0, 7)).val(datum.ID)
  return

$('#groups_combobox').change ->
  if $(this).val() == 0
    $('#party_combobox').val(0)
  else
    $.ajax
      url: '/songs/getParty.json'
      data:
        groups: $('#groups_combobox').val()

      type: 'get'
      dataType: 'json'
      success: (data) ->
        $('#party_combobox').html('')
        $('#party_combobox').append "<option value=0></option>"
        $.each data, (i, o)->
          $('#party_combobox').append "<option value="+o.id+">"+o.name+"</option>"
          return

        return