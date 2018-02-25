App.chat = App.cable.subscriptions.create "ChatChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # append message
    $('.chatMessages').append(data.message);

    # clear #message_content input field
    $('#message_content').val('');
