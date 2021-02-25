class MedicationsController < ApplicationController

    get "/medications" do
        if logged_in?
            @meds = @current_user.medications.order
            if @meds.user_id == @current_user.id || @current_user.family_members.include?(@meds.family_member_id)
                erb :"/medications/index"
            else
                flash[:alert] = "You can only view yours or your family member's medications."
                redirect to "/users/hompage"
            end
        else
            flash[:alert] = "You must be logged in to view your medications."
            redirect to "/login"
        end
    end

    get "/medications/new" do
        if logged_in?
            erb :"/medications/new"
        else
            flash[:alert] = "You must be logged in to submit a new medication."
            redirect to "/login"
        end
    end

    post "/medications" do
        @med = Medication.create(params)
        redirect to "/medications/#{@med.id}"
    end

    get "/medications/:id/edit" do
        if logged_in?
            @med = Medication.find_by(id: params[:id])
            if @med.user_id == @current_user.id || @current_user.family_members.include?(@med.family_member_id)
                erb :"/medications/edit"
            else
                flash[:alert] = "You can only edit the medications that belong to either you or your family members."
                redirect to "/medications"
            end
        else
            flash[:alert] = "You must be logged in to edit any of your medications."
            redirect to "/login"
        end       
    end

    patch "/medications/:id" do
        @med = Medication.find_by(id: params[:id])
        if @med.user_id == @current_user.id || @current_user.family_members.include?(@med.family_member_id)
            @med.update(name: params[:name], dose: params[:dose], form: params[:form], route: params[:route], time_to_be_taken: params[:time_to_be_taken], category: [:category], prescription_number: params[:prescription_number], date_filled: params[:date_filled], refill_date: params[:refill_date], discard_or_expiration_date: params[:discard_or_expiration_date], side_effects: params[:side_effects], notes: params[:notes]) 
            redirect to "/medications/#{@med.id}"
        else
            flash[:alert] = "You can only edit the medications that belong to either you or your family members."
            redirect to "/medications"
        end
    end

    get "/medications/:id" do
        if logged_in?
            @med = Medication.find_by(id: params[:id])
            if @med.user_id == @current_user.id || @current_user.family_members.include?(@med.family_member_id)
                erb :"/medications/show"
            else
                flash[:alert] = "You can only view yours or your family member's medications."
                redirect to "/users/hompage"
            end
        else
            flash[:alert] = "You must be logged in to view your medications."
            redirect to "/login"
        end
    end

    delete "/medications/:id" do
        if logged_in?
            if @med.user_id == @current_user.id || @current_user.family_members.include?(@med.family_member_id)
                @med = Medication.find(params[:id])
                @med.destroy
                redirect to "/medications"
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