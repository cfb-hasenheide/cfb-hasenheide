class EventMailer < ApplicationMailer
  default from: %("CFB" <cfb@cfb-hasenheide.de>)

  after_action :set_from, :set_to, only: [:open_replies, :close_replies]

  def open_replies(event_id, to_user_ids:, from_user_id: nil, message: nil)
    @event = Event.find(event_id)
    @to_user_ids = to_user_ids
    @from_user_id = from_user_id
    @message = message.presence

    mail(subject: 'Neuer Termin in der Meldeliste freigegeben')
  end

  def close_replies(event_id, to_user_ids:, from_user_id: nil, message: nil)
    @event = Event.find(event_id)
    @to_user_ids = to_user_ids
    @from_user_id = from_user_id
    @message = message.presence

    mail(subject: "Final Call - #{@event.name} (#{@event.model_name.human})")
  end

  private

  def set_from
    return unless @from_user_id.present?

    user = User.includes(:user_profile).find(@from_user_id)

    mail.from = user.email_with_name
  end

  def set_to
    users = User.includes(:user_profile).find(@to_user_ids)

    mail.to = users.map(&:email_with_name).sort
  end
end
