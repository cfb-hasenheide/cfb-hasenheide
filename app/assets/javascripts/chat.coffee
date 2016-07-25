$ ->
  Chat.init() if $('#chatModal').length > 0

Chat =
  init: ->
    @chatModal = $('#chatModal')
    @loadMessagesLink = @chatModal.find('a')
    @loadMessages()

  loadMessages: ->
    @chatModal.on 'shown.bs.modal', =>
      @loadMessagesLink.click()
