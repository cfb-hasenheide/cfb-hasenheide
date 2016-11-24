$ ->
  if $('form.new_homepage_header, form.edit_homepage_header').length
    new HomepageHeaderForm

class HomepageHeaderForm
  constructor: ->
    # preview heading changes
    $('#homepage_header_heading').on 'change', ->
      value = $(event.target).val()
      $('.homepageHeader .heading').html(value)

    # preview text changes
    $('#homepage_header_text').on 'change', ->
      value = $(event.target).val()
      $('.homepageHeader .text').html(value)

    # preview background_position_y changes
    $('#homepage_header_background_position_y').on 'change', ->
      y = $(event.target).val()
      $('.homepageHeader').css('background-position', "0% #{y}%")

    # preview color input changes
    $('#homepage_header_color').on 'change', ->
      value = $(event.target).val()
      $('.homepageHeader').css('color', value)
