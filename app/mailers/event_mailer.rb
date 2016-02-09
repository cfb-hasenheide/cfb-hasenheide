class EventMailer < ApplicationMailer
  def open_replies(event_id, message: nil)
    @event = Event.find(event_id)
    @message = message.presence

    mail(to: 'to@example.com',
         subject: 'Neuer Termin in der Meldeliste freigegeben')
  end

  def close_replies(event_id, message: nil)
    @event = Event.find(event_id)
    @message = message.presence

    mail(to: 'to@example.com',
         subject: "Final Call - #{@event.name} (#{@event.model_name.human})")
  end
end
