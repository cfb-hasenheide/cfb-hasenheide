class ContactsController < ApplicationController
  def edit
    @contact = Contact.find params[:id]
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      flash[:notice] = 'Erfogreich geupdated'
      redirect_to player_path @contact.player
    else
      render 'edit'
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:lastname,
                                    :firstname,
                                    :phone1,
                                    :phone2,
                                    :date_of_birth,
                                    :club_email,
                                    :place_of_birth)
  end
end
