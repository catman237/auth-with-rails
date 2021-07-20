class UsersController < ApplicationController
    def index 
        @users = User.all
        render json: @users
    end

    def login

        @user = User.find_by(username: params[:user][:username])

        if !@user

            render json: { error: 'this is not a vaild username or password'}, status: :unauthorized

        else

            if !@user.authenticate (params[:user][:password])

                render json: { error: 'this is not a vaild username or password'}, status: :unauthorized

            else
                payload = { user_id: @user.id }

                secret = 'this is a secret'

                token = JWT.encode payload, secret

                render json: {token: token}, status: :ok

            end
        end
    end

    def create 
        @user = User.create user_params
        render json: @user
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end

end
