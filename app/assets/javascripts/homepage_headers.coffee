$ ->
  if $('form.new_homepage_header, form.edit_homepage_header').length
    new HomepageHeaderForm

class HomepageHeaderForm
  constructor: ->
    $('#homepage_header_background_position_y').on 'change', ->
      y = $(event.target).val()
      $('.homepageHeader').css('background-position', "0% #{y}%")
