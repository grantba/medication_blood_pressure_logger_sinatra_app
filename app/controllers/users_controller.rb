class UsersController < ApplicationController

    get "/login" do
        if !logged_in?
            erb :"/users/login" 
        else 
            redirect to "/users/#{@current_user.username}"          
        end
    end

    post "/login" do
        if user = User.find_by(username: params[:username])&.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to "/users/#{user.username}"
        else
            flash[:error] = "Your username and password could not be validated. Please log in or sign up if you have not created an account yet."
            redirect to "/"
        end
    end

end