$ ->
  ($ '.new_host').each ->
    form = $ @
    select = form.find('[name="host[subnet_id]"]')
    ipInput = form.find('[name="host[ip]"]')
    select.change ->
       ipInput.val select.find("""option[value="#{select.val()}"]""").data('ip-prefix')
  ($ '.edit_host').each ->
    form = $ @
    select = form.find('[name="host[subnet_id]"]')
    ipInput = form.find('[name="host[ip]"]')
    select.change ->
       ipInput.val select.find("""option[value="#{select.val()}"]""").data('ip-prefix')