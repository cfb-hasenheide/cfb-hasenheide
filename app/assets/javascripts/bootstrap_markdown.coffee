class BootstrapMarkdown
  constructor: ->
    @textArea = $('.bootstrapMarkdown')

    @textArea.markdown(
      footer: 'Testfooter'
      iconlibrary: 'fa' # FontAwesome
      language: 'de'
      hiddenButtons: ['cmdCode']
    )

$ ->
  new BootstrapMarkdown if $('.bootstrapMarkdown').length
