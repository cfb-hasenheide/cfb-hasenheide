class EventMailer < ApplicationMailer
  def open_replies(event_id)
    @event = Event.find(event_id)

    mail(to: 'thilo@cfb-hasenheide.de',
         subject: 'Neuer Termin in der Meldeliste freigegeben')
  end
end
