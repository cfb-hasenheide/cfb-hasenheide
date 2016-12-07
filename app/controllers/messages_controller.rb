class MessagesController < ApplicationController
  def index
    @message = Message.new
    @messages = messages

    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      ActionCable.server.broadcast('chat', message: render(@message))
      head :ok
    end

    # respond_to do |format|
    #   format.js { render layout: false }
    # end
  end

  private

  def message_params
    params.require(:message).permit(:content, :user_id)
  end

  def messages
    Message.order(created_at: :desc).limit(100).reverse
  end
end
