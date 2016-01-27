class EventMailer < ApplicationMailer
  def open_replies(event_id)
    @event = Event.find(event_id)

    mail(to: 'to@example.com',
         subject: 'Neuer Termin in der Meldeliste freigegeben')
  end
end
