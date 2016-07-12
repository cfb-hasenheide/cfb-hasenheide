class MessagesController < ApplicationController
  def index
    @message = Message.new
    @messages = messages

    respond_to do |format|
      format.html
      format.js { render layout: false }
    end
  end

  def create
    @message = Message.new(message_params)

    @message.save

    respond_to do |format|
      format.js { render layout: false }
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
