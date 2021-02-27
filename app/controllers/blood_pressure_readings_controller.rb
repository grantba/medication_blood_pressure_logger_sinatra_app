class BloodPressureReadingsController < ApplicationController

    get "/bloodpressurereadings/users/:slug" do
        if logged_in?
            @user = User.find_by_matched_slug(params[:slug])
            if @user.id == @current_user.id 
                @bps = @current_user.bloodpressurereadings
                erb :"/bloodpressurereadings/users/index"
            else
                flash[:alert] = "You can only view yours or your family member's blood pressure readings."
                redirect to "/users/#{@current_user.username}"
            end
        else
            flash[:alert] = "You must be logged in to view your blood pressure readings."
            redirect to "/login"
        end
    end

    get "/bloodpressurereadings/users/:slug/new" do
        @user = User.find_by_matched_slug(params[:slug])
        if logged_in?
            if @user.id == @current_user.id 
                erb :"/bloodpressurereadings/users/new"
            else
                flash[:alert] = "You can only add new data to yours or your  member's blood pressure readings log."
                redirect to "/users/#{@current_user.username}"
            end
        else
            flash[:alert] = "You must be logged in to submit a new blood pressure reading."
            redirect to "/login"
        end
    end

    post "/bloodpressurereadings/users/:slug" do
        @user = User.find_by_matched_slug(params[:slug])
        if @user.id == @current_user.id
            @bp = BloodPressureReading.new(params)
            @bp.user_id = @current_user.id 
            @bp.save
            redirect to "/bloodpressurereadings/users/#{@bp.id}"
        else
            flash[:alert] = "You can only add new data to yours or your  member's blood pressure readings log."
            redirect to "/users/#{@current_user.username}"
        end
    end

    get "/bloodpressurereadings/users/:id/edit" do
        if logged_in?
            @bp = BloodPressureReading.find_by(id: params[:id])
            if @bp.user_id == @current_user.id
                erb :"/bloodpressurereadings/users/edit"
            else
                flash[:alert] = "You can only edit the blood pressure readings that belong to either you or your family members."
                redirect to "/bloodpressurereadings/users"
            end
        else
            flash[:alert] = "You must be logged in to edit any of your blood pressure readings."
            redirect to "/login"
        end       
    end

    patch "/bloodpressurereadings/users/:id" do
        @bp = BloodPressureReading.find_by(id: params[:id])
        if @bp.user_id == @current_user.id 
            @bp.update(name: params[:name], dose: params[:dose], form: params[:form], route: params[:route], time_to_be_taken: params[:time_to_be_taken], category: [:category], prescription_number: params[:prescription_number], date_filled: params[:date_filled], refill_date: params[:refill_date], discard_or_expiration_date: params[:discard_or_expiration_date], side_effects: params[:side_effects], notes: params[:notes]) 
            redirect to "/bloodpressurereadings/users/#{@bp.id}"
        else
            flash[:alert] = "You can only edit the blood pressure readings that belong to either you or your family members."
            redirect to "/bloodpressurereadings/users"
        end
    end

    get "/bloodpressurereadings/users/:id" do
        if logged_in?
            @bp = BloodPressureReading.find_by(id: params[:id])
            if @bp.user_id == @current_user.id 
                erb :"/bloodpressurereadings/users/show"
            else
                flash[:alert] = "You can only view yours or your family member's blood pressure readings."
                redirect to "/users/hompage"
            end
        else
            flash[:alert] = "You must be logged in to view your blood pressure readings."
            redirect to "/login"
        end
    end

    delete "/bloodpressurereadings/users/:id" do
        if logged_in?
            @bp = BloodPressureReading.find_by(id: params[:id])
            if @bp.user_id == @current_user.id 
                @bp.destroy
                redirect to "/bloodpressurereadings/users"
            else
                flash[:alert] = "You can only delete yours or your family member's blood pressure readings."
                redirect to "/users/hompage"
            end
        else
            flash[:alert] = "You must be logged in to delete any of your blood pressure readings."
            redirect to "/login"
        end
    end

end