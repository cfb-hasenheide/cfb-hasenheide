class ContactsController < ApplicationController
  def edit
    @contact = Contact.find params[:id]
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      flash[:notice] = 'Erfogreich geupdated'
      redirect_to player_path @contact.member.player
    else
      render 'edit'
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:phone1,
                                    :phone2,
                                    :club_email)
  end
end
