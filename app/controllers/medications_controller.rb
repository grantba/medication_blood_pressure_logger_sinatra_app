class MedicationsController < ApplicationController

    get "/medications" do 
        if logged_in?
            if current_user
                @meds = current_user.medications
                erb :"/medications/index"
            else
                flash[:alert] = "You can only view your own medications."
                redirect to "/users/#{current_user.username}"
            end
        else
            flash[:alert] = "You must be logged in to view your medications."
            redirect to "/login"
        end
    end

    get "/medications/:slug/new" do
        @user = User.find_by_matched_slug(params[:slug])
        if logged_in?
            if @user.id == current_user.id 
                erb :"/medications/new"
            else
                flash[:alert] = "You can only add new medications to your own medication log."
                redirect to "/medications"
            end
        else
            flash[:alert] = "You must be logged in to submit a new medication."
            redirect to "/login"
        end
    end

    post "/medications" do
        if logged_in?
            if current_user
                @med = Medication.new(params)
                @med.user_id = current_user.id 
                @med.save
                redirect to "/medications/#{@med.id}"
            else
                flash[:alert] = "You can only add new medications to your medication log."
                redirect to "/medications"
            end
        else
            flash[:alert] = "You must be logged in to submit a new medication."
            redirect to "/login"
        end
    end

    get "/medications/:id/edit" do
        if logged_in?
            @med = Medication.find_by(id: params[:id])
            if @med.user_id == current_user.id
                erb :"/medications/edit"
            else
                flash[:alert] = "You can only edit the medications that belong to you."
                redirect to "/medications"
            end
        else
            flash[:alert] = "You must be logged in to edit any of your medications."
            redirect to "/login"
        end       
    end

    patch "/medications/:id" do
        med = Medication.find_by(id: params[:id])
        if med.user_id == current_user.id 
            med.side_effect = params[:side_effects] unless params[:side_effects].blank?
            med.notes = params[:notes] unless params[:notes].blank?
            med.save 
            med.update(name: params[:name], dose: params[:dose], form: params[:form], route: params[:route], time_to_be_taken: params[:time_to_be_taken], category: params[:category], prescription_number: params[:prescription_number], date_filled: params[:date_filled], refill_date: params[:refill_date], discard_or_expiration_date: params[:discard_or_expiration_date]) 
            flash[:message] = "Your medication's information has been updated successfully!"
            redirect to "/medications/#{med.id}"
        else
            flash[:alert] = "You can only edit the medications that belong to you."
            redirect to "/medications"
        end
    end

    get "/medications/:id" do
        if logged_in?
            @med = Medication.find_by(id: params[:id])
            if @med.user_id == current_user.id 
                erb :"/medications/show"
            else
                flash[:alert] = "You can only view your own medications."
                redirect to "/users/#{current_user.username}"
            end
        else
            flash[:alert] = "You must be logged in to view your medications."
            redirect to "/login"
        end
    end

    delete "/medications/:id" do
        if logged_in?
            @med = Medication.find_by(id: params[:id])
            if @med.user_id == current_user.id 
                @med.destroy
                redirect to "/medications"
            else
                flash[:alert] = "You can only delete your own medications."
                redirect to "/medications"
            end
        else
            flash[:alert] = "You must be logged in to delete any of your medications."
            redirect to "/login"
        end
    end
  
end