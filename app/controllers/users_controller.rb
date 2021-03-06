class UsersController < ApplicationController
  
  before_action :signed_in_user, only: [:index, :edit, :update, :show, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end
  
  def new
    @user = User.new()
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Seja Bem Vindo ao Sistema Exemplo!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Cadastro Atualizado!"
      redirect_to @user
    else
      render 'edit'
    end  
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
  
  def signed_in_user
    redirect_to signin_url, notice: "Por favor, faca o login." unless signed_in?
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user) 
  end
  
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  
end
