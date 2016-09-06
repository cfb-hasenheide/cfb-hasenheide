class AddressesController < ApplicationController
  def edit
    @address = Address.find params[:id]
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = 'Erfogreich geupdated'
      redirect_to player_path(redirect_path_model)
    else
      render 'edit'
    end
  end

  def new
    @address = Member.find(params[:member_id]).build_address
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      flash[:notice] = 'Adresse erfolgreich angelegt'
    else
      flash[:alert] = 'Adresse konnte nicht angelegt werden'
    end
    redirect_to redirect_path_model
  end

  private

  def address_params
    params.require(:address).permit(:street, :zipcode, :city,
                                    :addressable_id, :addressable_type)
  end

  def redirect_path_model
    @address.try(:addressable).try(:player)
  end
end
