class BootstrapMarkdown
  constructor: ->
    @textArea = $('.bootstrapMarkdown')

    @textArea.markdown(
      footer: 'Testfooter'
      iconlibrary: 'fa' # FontAwesome
      language: 'de'
    )

$ ->
  new BootstrapMarkdown if $('.bootstrapMarkdown').length
