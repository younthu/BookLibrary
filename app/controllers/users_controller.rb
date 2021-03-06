class UsersController < ApplicationController
  before_filter :find_user, except: [:new, :create, :index]
  before_filter :authorize_admin, only: [:edit, :create, :new, :index, :update]

  def index
    @users = User.all.page(params[:page]).per(15)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @user = User.new
  end

  def update
    @user.update_attributes(update_user_params)
    if @user.save
      flash[:notice] = t('user_saved')
      redirect_to users_admin_path(@user)
    else
      flash[:alert] = t('check_required_field')
      redirect_to users_admin_path(@user)
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #Nb::People.add_tag(@user.email, 'Library_account_active')
      flash[:notice] = t('user_saved')
      redirect_to users_admin_index_path
    else
      flash[:alert] = t('check_required_field') +":"+ @user.errors.full_messages[0]
      puts @user.errors
      redirect_to new_users_admin_path
    end
  end

  def make_admin
    @user.make_admin
    #FIXME: bring Nb back
    #Nb::People.add_tag(@user.email, 'Library_Admin')
    flash[:notice] = t('someone_is_now_admin', user_name: @user.name) #{}"#{@user.name} is now an admin"
    redirect_to users_admin_index_path
  end

  def remove_admin
    @user.remove_admin
    #Nb::People.remove_tag(@user.email, 'Library_Admin')
    flash[:notice] = t('someone_is_no_longer_admin', user_name: @user.name) #{}"#{@user.name} is no longer an admin"
    redirect_to users_admin_index_path
  end

  def destroy
    #Nb::People.remove_tag(@user.email, 'Library_account_active')
    #Nb::People.add_tag(@user.email, 'Library_account_deleted')
    @user.destroy
    flash[:notice] = t('user_has_been_deleted')#'User has been deleted'
    redirect_to users_admin_index_path
  end

  private

  def find_user
    @user = User.find(params[:id])
    #puts "trying to find " + @user.email
    #FIXME: bring Nb back by apply NATION_SLUG and NATION_TOKEN
    #@profile_image = Nb::People.find_signup_image(@user.email)
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
      :admin,
      :location_id)
  end

  def update_user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :location_id)
  end
end
