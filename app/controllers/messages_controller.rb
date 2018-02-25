class MessagesController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.js do
        @messages = messages
        render layout: false
      end
    end
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      ActionCable.server.broadcast('chat', message: render(@message))
      head :ok
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :user_id)
  end

  def messages
    Message.order(created_at: :desc).page(params[:page])
  end
end
