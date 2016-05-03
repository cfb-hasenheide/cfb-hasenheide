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

    player = Player.find_by(user_id: @from_user_id)

    mail.from = player.club_email_with_nickname
  end

  def set_to
    players = Player.find_by(user_id: @to_user_ids)

    mail.to = players.map(&:club_email_with_nickname).sort
  end
end
