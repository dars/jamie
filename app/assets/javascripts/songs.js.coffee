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