$ ->
  new ChatModal if $('#chatModal').length
  new ChatView if $('#chatView').length

class ChatModal
  constructor: ->
    @chatModal = $('#chatModal')
    @messages = @chatModal.find('.chatMessages')
    @loadMessagesLink = @chatModal.find('.chatRefresh')
    @loadMessages()

  loadMessages: ->
    @chatModal.on 'shown.bs.modal', =>
      @loadMessagesLink.click() if @messages.is(':empty')

class ChatView
  constructor: ->
    @chatView = $('#chatView')
    @messages = @chatView.find('.chatMessages')
    @loadMessagesLink = @chatView.find('.chatRefresh')
    @loadMessages()

  loadMessages: ->
    @loadMessagesLink.click()
