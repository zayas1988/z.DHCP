$ ->
  ($ '.new_host').each ->
    form = $ @
    subselect = form.find('[name="host[subnet_id]"]')
    ipInput = form.find('[name="host[ip]"]')
    freeselect = form.find('[name="freeips"]')
    subselect.change ->
       ipInput.val subselect.find("""option[value="#{subselect.val()}"]""").data('ip-prefix')
    freeselect.change ->
       ipInput.val freeselect.val()

    $('select[name="host[subnet_id]"').change ->
      $.ajax
        url: "/getfreeips/#{$(@).val()}"
        type: 'GET'
        dataType: 'html'
        success: (result)->$('select[name="freeips"]').html(result)
  ($ '.edit_host').each ->
    form = $ @
    subselect = form.find('[name="host[subnet_id]"]')
    ipInput = form.find('[name="host[ip]"]')
    freeselect = form.find('[name="freeips"]')
    subselect.change ->
       ipInput.val subselect.find("""option[value="#{subselect.val()}"]""").data('ip-prefix')
    freeselect.change ->
       ipInput.val freeselect.val()
    $('select[name="host[subnet_id]"').change ->
      $.ajax
        url: "/getfreeips/#{$(@).val()}"
        type: 'GET'
        dataType: 'html'
        success: (result)->$('select[name="freeips"]').html(result)

       