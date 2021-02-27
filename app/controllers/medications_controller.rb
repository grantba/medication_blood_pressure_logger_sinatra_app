class MedicationsController < ApplicationController

    get "/medications/users/:slug" do 
        if logged_in?
            @user = User.find_by_matched_slug(params[:slug])
            if @user.id == current_user.id
                @meds = @user.medications
                erb :"/medications/users/index"
            else
                flash[:alert] = "You can only view yours or your family member's medications."
                redirect to "/users/#{@user.username}"
            end
        else
            flash[:alert] = "You must be logged in to view your medications."
            redirect to "/login"
        end
    end

    get "/medications/users/:slug/new" do
        @user = User.find_by_matched_slug(params[:slug])
        if logged_in?
            if @user.id == @current_user.id 
                erb :"/medications/users/new"
            else
                flash[:alert] = "You can only add new medications to yours or your familys member's medication log."
                redirect to "/users/#{@current_user.username}"
            end
        else
            flash[:alert] = "You must be logged in to submit a new medication."
            redirect to "/login"
        end
    end

    post "/medications/users" do
        if !!current_user
            @med = Medication.new(params)
            @med.user_id = current_user.id 
            @med.save
            redirect to "/medications/users/#{@med.id}"
        else
            flash[:alert] = "You can only add new medications to yours or your familys member's medication log."
            redirect to "/users/#{current_user.username}"
        end
    end

    get "/medications/users/:id/edit" do
        if logged_in?
            @med = Medication.find_by(id: params[:id])
            if @med.user_id == @current_user.id
                erb :"/medications/users/edit"
            else
                flash[:alert] = "You can only edit the medications that belong to either you or your family members."
                redirect to "/medications/users"
            end
        else
            flash[:alert] = "You must be logged in to edit any of your medications."
            redirect to "/login"
        end       
    end

    patch "/medications/users/:id" do
        @med = Medication.find_by(id: params[:id])
        if @med.user_id == current_user.id 
            @med.update(name: params[:name], dose: params[:dose], form: params[:form], route: params[:route], time_to_be_taken: params[:time_to_be_taken], category: [:category], prescription_number: params[:prescription_number], date_filled: params[:date_filled], refill_date: params[:refill_date], discard_or_expiration_date: params[:discard_or_expiration_date], side_effects: params[:side_effects], notes: params[:notes]) 
            redirect to "/medications/users/#{@med.id}"
        else
            flash[:alert] = "You can only edit the medications that belong to either you or your family members."
            redirect to "/medications/users"
        end
    end

    get "/medications/users/:id" do
        if logged_in?
            @med = Medication.find_by(id: params[:id])
            if @med.user_id == current_user.id 
                erb :"/medications/users/show"
            else
                flash[:alert] = "You can only view yours or your family member's medications."
                redirect to "/users/hompage"
            end
        else
            flash[:alert] = "You must be logged in to view your medications."
            redirect to "/login"
        end
    end

    delete "/medications/users/:id" do
        if logged_in?
            @med = Medication.find_by(id: params[:id])
            if @med.user_id == @current_user.id 
                @med.destroy
                redirect to "/medications/users"
            else
                flash[:alert] = "You can only delete yours or your family member's medications."
                redirect to "/users/hompage"
            end
        else
            flash[:alert] = "You must be logged in to delete any of your medications."
            redirect to "/login"
        end
    end
  
end