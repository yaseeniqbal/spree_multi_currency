$ ->
  $('#currency').on 'change', ->
    $("#currency_change_form").submit()
#    $.ajax(
#      type: 'POST'
#      url: $(this).data('href')
#      data:
#        currency: $(this).val()
#    ).done ->
#      window.location.reload()
