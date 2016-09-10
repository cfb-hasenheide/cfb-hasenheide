$ ->
  Offcanvas.init()

Offcanvas =
  init: ->
    @toggleOffcanvasLink = $('a[data-toggle="offcanvas"]')
    @offcanvas = $('.row-offcanvas')

    @toggleOffcanvasLink.on 'click', =>
      @offcanvas.toggleClass('active')
