$ ->
  Chat.init() if $('#chatModal').length > 0

Chat =
  init: ->
    @chatModal = $('#chatModal')
    @messages = @chatModal.find('#messages')
    @loadMessagesLink = @chatModal.find('a')
    @loadMessages()

  loadMessages: ->
    @chatModal.on 'shown.bs.modal', =>
      @loadMessagesLink.click() if @messages.is(':empty')
