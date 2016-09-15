class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @roles = Role.all
    @role = Role.new
    respond_with(@roles)
  end

  def show
    respond_with(@role)
  end

  def edit
    authorize!(:update, @role)
    @roles = Role.all
    render 'index'
  end

  def create
    @role = Role.new(role_params)
    authorize!(:create, @role)
    @role.save
    respond_with(@role)
  end

  def update
    authorize!(:update, @role)
    @role.update(role_params)
    respond_with(@role)
  end

  def destroy
    authorize!(:destoy, @role)
    @role.destroy
    respond_with(@role)
  end

  private

  def set_role
    @role = Role.find(params[:id])
  end

  def role_params
    params.require(:role).permit(:name)
  end
end
