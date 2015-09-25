class RegistrationsController < Devise::RegistrationsController

  def new
    flash[:info] = 'Aktuell kannst Du dich nicht selbst registrieren, bitte ' \
      "schicke eine E-Mail an 'thilo@cfb-hasenheide.de'"
    redirect_to root_path
  end

  def create
    flash[:info] = 'Aktuell kannst Du dich nicht selbst registrieren, bitte ' \
      "schicke eine E-Mail an 'thilo@cfb-hasenheide.de'"
    redirect_to root_path
  end

end
