class MessagesController < ApplicationController
  def index
    @message = Message.new
    @messages = messages
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      redirect_to messages_path, notice: 'Nachricht erfolgreich gesendet.'
    else
      @messages = messages
      render :index
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :user_id)
  end

  def messages
    Message.order(:created_at).page(params[:page])
  end
end
