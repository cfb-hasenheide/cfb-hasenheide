class BootstrapMarkdown
  constructor: ->
    @textArea = $('.bootstrapMarkdown')

    @textArea.markdown(
      footer: 'Testfooter'
      iconlibrary: 'fa' # FontAwesome
      language: 'de'
      hiddenButtons: ['cmdCode']
      additionalButtons: [ [ {
        name: 'groupMisc'
        data: [ {
          name: 'cmdTable'
          toggle: true
          title: 'Tabelle'
          icon:
            fa: 'fa fa-table fa-fw'
          callback: (e) ->
            # Replace selection with some drinks
            cursor = undefined
            selected = e.getSelection()
            content = e.getContent()
            tableTemplate = """
              Spalte 1 | Spalte 2 | Spalte 3
              -------- | :------: | -------:
              linksbündig | mittig | rechtsbündig
              noch | eine | Zeile
            """
            # transform selection and set the cursor into chunked text
            e.replaceSelection tableTemplate
            cursor = selected.start
            # Set the cursor
            e.setSelection cursor, cursor + tableTemplate.length
        } ]
      } ] ]
    )

$ ->
  new BootstrapMarkdown if $('.bootstrapMarkdown').length
