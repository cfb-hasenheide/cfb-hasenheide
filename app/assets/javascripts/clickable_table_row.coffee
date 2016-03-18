$ ->
  if $('.clickableTableRow').length > 0
    $('.clickableTableRow').on 'click', ->
      window.document.location = $(@).data('url')
