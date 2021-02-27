class UsersController < ApplicationController

    get "/login" do
        if !logged_in?
            erb :"/users/login" 
        else 
            redirect to "/users/#{current_user.username}"          
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
            if @user.id == current_user.id
                erb :"/users/edit"
            else
                flash[:error] = "You can only edit your own information."
                redirect to "/users/#{@user.username}"
            end
        else
            flash[:error] = "You are not currently logged in to your account. Please log in or sign up if you have not created an account yet."
            redirect to "/"
        end
    end

    patch "/users/:slug" do
        user = User.find_by_matched_slug(params[:slug])
        if user.id == current_user.id
            user.name = params[:name] unless params[:name].blank?
            user.username = params[:username] unless params[:username].blank?
            user.password = params[:password] unless params[:password].blank?
            user.save 
            user.update(date_of_birth: params[:date_of_birth], address: params[:address], phone_number: params[:phone_number], email: params[:email])
            flash[:message] = "Your information has been updated successfully!"
            redirect to "/users/#{user.username}"
        else
            flash[:error] = "You can only edit your own information."
            redirect to "/users/#{user.username}"
        end
    end

    get "/users/:slug" do
        if logged_in?
            @user = User.find_by_matched_slug(params[:slug])
            if @user.id == current_user.id
                erb :"/users/homepage"
            else
                flash[:error] = "You can only view your own account information."
                redirect to "/users/login"
            end
        else
            flash[:error] = "You are not currently logged in to your account. Please log in or sign up if you have not created an account yet."
            redirect to "/"
        end
    end

    get "/signup" do
        if !logged_in?
            erb :"/users/signup"      
        else 
            flash[:notice] = "You already have a user account."
            redirect to "/users/#{current_user.username}"
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
        if logged_in?
            flash[:notice] = "Thanks for visiting today, #{current_user.name}. See you again soon!"
            session.clear
            redirect to "/"
        else
            flash[:error] = "You are not currently logged in to your account."
            redirect to "/"
        end
    end

    delete "/users/:slug" do
        session[:count] = 1 unless session[:count] == 2
        if logged_in?
            user = User.find_by_matched_slug(params[:slug])
            if  user.id == current_user.id && session[:count] == 1
                session[:count] =2
                flash[:warning] = "Are you sure you want to delete your account?"
                redirect to "/users/#{user.username}"
            elsif user.id == current_user.id && session[:count] == 2
                flash[:notice] = "We're sad to see you go #{user.name}, but thanks for visiting!"
                user.destroy
                redirect to "/"
            else
                flash[:error] = "You can only delete your own account."
                redirect to "/users/login"
            end  
        else
            flash[:error] = "You must be logged in to delete your account. Please try again."
            redirect to "/"
        end   
    end

end