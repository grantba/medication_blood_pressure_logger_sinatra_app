class PharmaciesController < ApplicationController

    get "/pharmacies/:slug/all" do 
        @user = User.find_by_matched_slug(params[:slug])
        if logged_in?
            if @user && @user.id == current_user.id 
                @pharmacies = Pharmacy.select {|pharmacy| pharmacy.user_id == @user.id}
                erb :"/pharmacies/index"
            else
                flash[:alert] = "You can only view the pharmacy information that belongs to you."
                redirect to "/users/#{current_user.username}"
            end
        else
            flash[:alert] = "You must be logged in to view your pharmacy information."
            redirect to "/login"
        end
    end

    get "/pharmacies/:id/new" do
        if logged_in?
            @med = Medication.find_by(id: params[:id])
            @pharmacies = Pharmacy.select {|pharmacy| pharmacy.user_id == current_user.id}
            if current_user && @med.user_id == current_user.id 
                erb :"/pharmacies/new"
            else
                flash[:alert] = "You can only add a new pharmacy to your own medications."
                redirect to "/medications/#{current_user.username}/all"
            end
        else
            flash[:alert] = "You must be logged in to submit a new pharmacy to your account."
            redirect to "/login"
        end
    end

    post "/pharmacies/:id" do
        if logged_in?
            @med = Medication.find_by(id: params[:id])
            if current_user && @med.user_id == current_user.id 
                if pharmacy = Pharmacy.find_by(id: params[:pharmacy_id])
                    @med.pharmacy_id = pharmacy.id
                    @med.save
                else
                    pharmacy = Pharmacy.new(params.except("id", "pharmacy_id"))
                    pharmacy.user_id = current_user.id
                    pharmacy.save
                    @med.pharmacy_id = pharmacy.id
                    @med.save
                end
                redirect to "/pharmacies/#{pharmacy.id}"
            else
                flash[:alert] = "You can only add a new pharmacy to your own medications."
                redirect to "/medications/#{current_user.username}/all"
            end
        else
            flash[:alert] = "You must be logged in to submit a new pharmacy to your account."
            redirect to "/login"
        end
    end

    get "/pharmacies/:id/edit" do
        if logged_in?
            @pharmacy = Pharmacy.find_by(id: params[:id])
            if current_user && @pharmacy.user_id == current_user.id
                erb :"/pharmacies/edit"
            else
                flash[:alert] = "You can only edit the pharmacy information that belongs to you."
                redirect to "/pharmacies/#{current_user.username}/all"
            end
        else
            flash[:alert] = "You must be logged in to edit any of your pharmacy information."
            redirect to "/login"
        end       
    end

    patch "/pharmacies/:id" do
        pharmacy = Pharmacy.find_by(id: params[:id])
        if current_user && pharmacy.user_id == current_user.id 
            pharmacy.notes = params[:notes] unless params[:notes].blank?
            pharmacy.save 
            pharmacy.update(name: params[:name], address: params[:address], phone_number: params[:phone_number], website: params[:website])
            redirect to "/pharmacies/#{pharmacy.id}"
        else
            flash[:alert] = "You can only edit the pharmacy information that belongs to you."
            redirect to "/pharmacies/#{current_user.username}/all"
        end
    end

    get "/pharmacies/:id" do
        if logged_in?
            @pharmacy = Pharmacy.find_by(id: params[:id])
            if current_user && @pharmacy.user_id == current_user.id 
                @meds = Medication.select {|med| med.pharmacy_id == @pharmacy.id}
                erb :"/pharmacies/show"
            else
                flash[:alert] = "You can only view the pharmacy information that belongs to you."
                redirect to "/users/#{current_user.username}"
            end
        else
            flash[:alert] = "You must be logged in to view your pharmacy information."
            redirect to "/login"
        end
    end

    delete "/pharmacies/:id" do
        number = params[:id]
        session[pharmacy: number] = 1 unless session[pharmacy: number] == 2
        if logged_in?
            pharmacy = Pharmacy.find_by(id: params[:id])
            if current_user && pharmacy.user_id == current_user.id && session[pharmacy: number] == 1
                session[pharmacy: number] = 2
                flash[:warning] = "Are you sure you want to delete the pharmacy, #{pharmacy.name}, from your account?" 
                redirect to "/pharmacies/#{current_user.username}/all"
            elsif current_user && pharmacy.user_id == current_user.id && session[pharmacy: number] == 2
                @meds = Medication.select {|med| med.pharmacy_id == pharmacy.id}
                @meds.each do |med| 
                    med.pharmacy_id = ""
                    med.save
                end
                pharmacy.destroy
                flash[:notice] = "#{pharmacy.name} has been deleted from your account and removed from any associated medications."
                redirect to "/pharmacies/#{current_user.username}/all"
            else
                flash[:alert] = "You can only delete a pharmacy that belongs to your own account."
                redirect to "/pharmacies/#{current_user.username}/all"
            end
        else
            flash[:alert] = "You must be logged in to delete a pharmacy that belongs to you."
            redirect to "/login"
        end
    end

end