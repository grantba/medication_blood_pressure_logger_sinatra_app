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

    get "/users/:slug/edit" do
        if logged_in?
            @user = User.find_by_matched_slug(params[:slug])
            erb :"/users/edit"
        else
            flash[:error] = "You are not currently logged in to your account. Please log in or sign up if you have not created an account yet."
                redirect to "/"
            end
    end

    patch "/users/:slug" do
        @user = User.find_by_matched_slug(params[:slug])
        @user.name = params[:name] unless params[:name].blank?
        @user.date_of_birth = params[:date_of_birth] unless params[:date_of_birth].blank?
        @user.address = params[:address] unless params[:address].blank?
        @user.phone_number = params[:phone_number] unless params[:phone_number].blank?
        @user.email = params[:email] unless params[:email].blank?
        @user.username = params[:username] unless params[:username].blank?
        @user.password = params[:password] unless params[:password].blank?
        @user.save 
        flash[:message] = "Your information has been updated successfully!"
        redirect to "/users/#{@user.username}"
    end

    get "/users/:slug" do
        if logged_in?
            @user = User.find_by_matched_slug(params[:slug])
            erb :"/users/homepage"
        else
            flash[:error] = "You are not currently logged in to your account. Please log in or sign up if you have not created an account yet."
            redirect to "/"
        end
    end

    get "/signup" do
        if !logged_in?
            erb :"/users/signup"      
        else 
            redirect to "/users/#{@current_user.username}"
        end
    end

    post "/signup" do
        if params[:name].empty? || params[:username].empty? || params[:password].empty?
            flash[:error] = "The name, username, and password fields can not be empty. Please try again."
            redirect to "/signup"
        elsif User.find_by(username: params[:username])
            flash[:error] = "That username has already been taken. Please try again."
            redirect to "/signup"
        else
            user = User.create(params)
            session[:user_id] = user.id
            redirect to "/users/#{user.username}"
        end
    end

    get "/users/:slug/logout" do
        if logged_in? && @current_user = User.find_by_matched_slug(params[:slug])
            flash[:notice] = "Thanks for visiting today, #{@current_user.name}. See you again soon!"
            session.destroy
            redirect to "/"
        else
            flash[:error] = "You are not currently logged in to your account."
            redirect to "/"
        end
    end

    delete "/users/:slug" do
        if logged_in? && @current_user = User.find_by_matched_slug(params[:slug])
            flash[:notice] = "We're sad to see you go #{@current_user.name}, but thanks for visiting!"
            @current_user.destroy
            redirect to "/"
        else
            flash[:error] = "You must be logged in to delete your account. Please try again."
            redirect to "/"
        end   
    end

end