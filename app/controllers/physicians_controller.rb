class PhysiciansController < ApplicationController

    get "/physicians/:slug/all" do 
        @user = User.find_by_matched_slug(params[:slug])
        if logged_in?
            if @user.id == current_user.id 
                @physicians = Physician.select {|physician| physician.user_id == @user.id}
                erb :"/physicians/index"
            else
                flash[:alert] = "You can only view your own physicians' information."
                redirect to "/users/#{current_user.username}"
            end
        else
            flash[:alert] = "You must be logged in to view your physicians' information."
            redirect to "/login"
        end
    end

    get "/physicians/:id/new" do
        if logged_in?
            @med = Medication.find_by(id: params[:id])
            if @med.user_id == current_user.id 
                erb :"/physicians/new"
            else
                flash[:alert] = "You can only add new physicians to your own physician's log."
                redirect to "/physicians/#{current_user.username}/all"
            end
        else
            flash[:alert] = "You must be logged in to submit a new physician."
            redirect to "/login"
        end
    end

    post "/physicians/:id" do
        if logged_in?
            @med = Medication.find_by(id: params[:id])
            if @med.user_id == current_user.id 
                physician = Physician.new(params.except("id"))
                physician.user_id = current_user.id
                physician.save
                @med.physician_id = physician.id
                @med.save
                redirect to "/physicians/#{physician.id}"
            else
                flash[:alert] = "You can only add new physicians to your own physician's log."
                redirect to "/physicians/#{user.username}/all"
            end
        else
            flash[:alert] = "You must be logged in to submit a new physician."
            redirect to "/login"
        end
    end

    get "/physicians/:id/edit" do
        if logged_in?
            @physician = Physician.find_by(id: params[:id])
            if @physician.user_id == current_user.id
                erb :"/physicians/edit"
            else
                flash[:alert] = "You can only edit the physician information that belongs to you."
                redirect to "/physicians/#{current_user.username}/all"
            end
        else
            flash[:alert] = "You must be logged in to edit any of your physician's information."
            redirect to "/login"
        end       
    end

    patch "/physicians/:id" do
        physician = Physician.find_by(id: params[:id])
        if physician.user_id == current_user.id 
            physician.notes = params[:notes] unless params[:notes].blank?
            physician.save 
            physician.update(name: params[:name], address: params[:address], phone_number: params[:phone_number], website: params[:website]) 
            flash[:message] = "Your physician's information has been updated successfully!"
            redirect to "/physicians/#{physician.id}"
        else
            flash[:alert] = "You can only edit the physician information that belongs to you."
            redirect to "/physicians/#{current_user.username}/all"
        end
    end

    get "/physicians/:id" do
        if logged_in?
            @physician = Physician.find_by(id: params[:id])
            if @physician.user_id == current_user.id 
                @meds = Medication.select {|med| med.physician_id == @physician.id}
                erb :"/physicians/show"
            else
                flash[:alert] = "You can only view your own physicians' information."
                redirect to "/users/#{current_user.username}"
            end
        else
            flash[:alert] = "You must be logged in to view your physicians' information."
            redirect to "/login"
        end
    end

    delete "/physicians/:id" do
        number = params[:id]
        session[physician: number] = 1 unless session[physician: number] == 2
        if logged_in?
            physician = Physician.find_by(id: params[:id])
            if physician.user_id == current_user.id && session[physician: number] == 1
                session[physician: number] = 2
                flash[:warning] = "Are you sure you want to delete your physician, #{physician.name}, from your account?" 
                redirect to "/physicians/#{current_user.username}/all"
            elsif physician.user_id == current_user.id && session[physician: number] == 2
                @meds = Medication.where()
                physician.destroy
                flash[:notice] = "#{physician.name} has been deleted from your account."
                redirect to "/physicians/#{current_user.username}/all"
            else
                flash[:alert] = "You can only delete your own physicians from your account."
                redirect to "/physicians/#{current_user.username}/all"
            end
        else
            flash[:alert] = "You must be logged in to delete any of your physicians."
            redirect to "/login"
        end
    end

end