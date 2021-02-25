class MedicationsController < ApplicationController

    get "/medications" do
        if logged_in?
            @medications = @current_user.medications
            erb :"/medications/index"
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
        @medication = Medication.create(params)
        redirect to "/medications/#{@medication.id}"
    end
  
    get "/medications/:id/edit" do
        if logged_in?
            @medication = Medication.find(params[:id])
            erb :"/medications/edit"
        else
            flash[:alert] = "You must be logged in to edit any of your medications."
            redirect to "/login"
        end       
    end
  
    patch "/medications/:id" do
        @medication = Medication.find(params[:id])
        @medication.update(params)
        @medication.save
        redirect to "/medications/#{@medication.id}"
    end
  
    get "/medications/:id" do
        if logged_in?
            @medication = Medication.find(params[:id])
            erb :"/medications/show"
        else
            flash[:alert] = "You must be logged in to view your medications."
            redirect to "/login"
        end
    end
  
    delete "/medications/:id" do
        if logged_in?
            @medication = Medication.find(params[:id])
            @medication.destroy
            redirect to "/medications"
        else
            flash[:alert] = "You must be logged in to delete any of your medications."
            redirect to "/login"
        end
    end
  
end