class UsersController < ApplicationController
  def index
    @users = User.all
    authorize @users
  end

  def edit
    @user = User.find(params[:id])
  end
end