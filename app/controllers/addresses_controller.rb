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

  private

  def address_params
    params.require(:address).permit(:street, :zipcode, :city)
  end

  def redirect_path_model
    @address.try(:addressable).try(:player)
  end
end
