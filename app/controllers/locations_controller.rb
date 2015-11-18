class LocationsController < ApplicationController
  before_filter :authorize_admin, only: [:edit, :create, :new, :update]
  before_filter :find_location, except: [:index, :create, :new]


  def index
    @locations = Location.all.page(params[:page]).per(15)
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      flash[:notice] = t('location_saved')
      redirect_to locations_path
    else
      flash[:alert] = t('check_required_field')
      redirect_to new_location_path
    end
  end

  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @location.destroy
    flash[:alert] = t('location_deleted')
    redirect_to locations_path
  end

  def update
    @location.update(location_params)
    if @location.save
      flash[:notice] = t('location_saved')
      redirect_to location_path(@location)
    else
      flash[:alert] = t('location_deleted')
      redirect_to locations_path
    end
  end

  private

  def find_location
    @location = Location.find(params[:id])
    @users = @location.users.page(params[:page]).per(10)
    @books = @location.books
  end

  def location_params
    params.require(:location).permit(
      :name,
      :address1,
      :address2,
      :city,
      :state,
      :zip,
      :country)
  end
end
