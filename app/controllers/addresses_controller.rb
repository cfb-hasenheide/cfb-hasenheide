class AddressesController < ApplicationController
  def edit
    @address = Address.find params[:id]
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = 'Erfogreich geupdated'
      redirect_to player_path @address.addressable
    else
      render 'edit'
    end
  end

  private

  def address_params
    params.require(:address).permit(:street, :zipcod, :city)
  end
end
