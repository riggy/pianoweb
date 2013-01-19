$ ->

  $(document).on('click', '.player-actions a', (event) ->
    $.post "/player/#{$(@).attr('rel')}"
  )