class BootstrapMarkdown
  constructor: ->
    @textArea = $('.bootstrapMarkdown')

    @textArea.markdown(
      footer: 'Testfooter'
      iconLibray: 'fa' # FontAwesome
      language: 'de'
    )

$ ->
  new BootstrapMarkdown if $('.bootstrapMarkdown').length
