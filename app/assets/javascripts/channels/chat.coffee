App.chat = App.cable.subscriptions.create "ChatChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # append message
    $('#messages').append(data.message);
    # scroll down to latest message
    $('#messages').closest('.modal-body')
                  .scrollTop($('#messages')
                  .closest('.modal-body')[0]
                  .scrollHeight);
    # clear #message_content input field
    $('#message_content').val('');
