class EventMailer < ApplicationMailer
  default from: %("CFB" <cfb@cfb-hasenheide.de>)

  after_action :set_from, :set_to,
               only: %i(attendance_list_closed attendance_list_opened)

  def attendance_list_opened(event_id,
                             to_player_ids:,
                             from_user_id: nil,
                             message: nil)
    @event = Event.find(event_id)
    @to_player_ids = to_player_ids
    @from_user_id = from_user_id
    @message = message.presence

    mail(subject: 'Neuer Termin in der Meldeliste freigegeben')
  end

  def attendance_list_closed(event_id,
                             time_to_meet: 30,
                             to_player_ids:,
                             from_user_id: nil,
                             message: nil)
    @event = Event.find(event_id)
    @to_player_ids = to_player_ids
    @time_to_meet = time_to_meet
    @from_user_id = from_user_id
    @message = message.presence

    mail(subject: "Final Call - #{@event.name} (#{@event.model_name.human})")
  end

  private

  def set_from
    return unless @from_user_id.present?

    player = Member.find_by(user_id: @from_user_id).player

    mail.from = player.club_email_with_nickname
  end

  def set_to
    players = Player.find(@to_player_ids)

    mail.to = players.map(&:club_email_with_nickname).sort
  end
end
