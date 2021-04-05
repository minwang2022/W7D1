class SessionsController < ApplicationController

    def create
        @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

        if user.nil?
            render :new
        else
            login!(@user)
            redirect_to cats_url
        end
    end

end