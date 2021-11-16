class Api::V1::RegistrationsController < Api::ApplicationController
  respond_to :json
  skip_before_action :verify_authenticity_token
  before_action :check_user, only: [:create]

def create
#debugger
if params[:user][:email].blank? || params[:user][:password].blank? || params[:user][:password_confirmation].blank?|| params[:user][:first_name].blank?|| params[:user][:last_name].blank?|| params[:user][:gender].blank?
render json: {status: "failed", message: "Missing parameters"}
else
@user = User.new(user_params)
@user.generate_auth_token!
if @user.save
debugger
render json: {status: "successful", user: { id: @user.id, email: @user.email, auth_token: @user.auth_token, first_name: @user.first_name, last_name: @user.last_name, created_at: @user.created_at, updated_at: @user.updated_at }}
else
render json: {status: "failed", user: @user.errors}
end
end
end
private

def user_params
params.require(:user).permit(:email,:password,:password_confirmation,:first_name,:last_name,:gender)
end


def check_user
debugger
if User.exists?(email: params[:user][:email],first_name: params[:user][:first_name],last_name: params[:user][:last_name],gender: params[:user][:gender])
render  json: {status: "failed", message: "User already exists"}
end
end
end