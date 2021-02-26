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

    get "/bloodpressurereadings/familymembers/:slug" do
        if logged_in?
            @user = User.find_by_matched_slug(params[:slug])
            @family = @user.family_members.group_by(:name)
            @bps = @user.family_members.blood_pressure_readings
            if @family.include?(@current_user.id)
                erb :"/bloodpressurereadings/familymembers/index"
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

    get "/bloodpressurereadings/familymembers/:slug/new" do
        @user = User.find_by_matched_slug(params[:slug])
        if logged_in?
            if @user.id == @current_user.id 
                erb :"/bloodpressurereadings/familymembers/new"
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

    post "/bloodpressurereadings/familymembers/:slug" do
        @user = User.find_by_matched_slug(params[:slug])
        if @user.id == @current_user.id
            @bp = BloodPressureReading.new(params)
            @bp.family_member_id = FamilyMember.find_by(name: params[:name])
            @bp.save
            redirect to "/bloodpressurereadings/familymembers/#{@bp.id}"
        else
            flash[:alert] = "You can only add new data to yours or your family member's blood pressure readings log."
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

    get "/bloodpressurereadings/familymembers/:id/edit" do
        if logged_in?
            @bp = BloodPressureReading.find_by(id: params[:id])
            if @current_user.family_members.include?(@bp.family_member_id)
                erb :"/bloodpressurereadings/familymembers/edit"
            else
                flash[:alert] = "You can only edit data that belongs to either you or your family members."
                redirect to "/bloodpressurereadings/familymembers"
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

    patch "/bloodpressurereadings/family/members/:id" do
        @bp = BloodPressureReading.find_by(id: params[:id])
        if @current_user.family_members.include?(@bp.family_member_id)
            @bp.update(name: params[:name], dose: params[:dose], form: params[:form], route: params[:route], time_to_be_taken: params[:time_to_be_taken], category: [:category], prescription_number: params[:prescription_number], date_filled: params[:date_filled], refill_date: params[:refill_date], discard_or_expiration_date: params[:discard_or_expiration_date], side_effects: params[:side_effects], notes: params[:notes]) 
            redirect to "/bloodpressurereadings/familymembers/#{@bp.id}"
        else
            flash[:alert] = "You can only edit the blood pressure readings that belong to either you or your family members."
            redirect to "/bloodpressurereadings/familymembers"
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

    get "/bloodpressurereadings/familymembers/:id" do
        if logged_in?
            @bp = BloodPressureReading.find_by(id: params[:id])
            if @current_user.family_members.include?(@bp.family_member_id)
                # or if @current_user.family_members.bloodpressurereadings.include?(@bp)
                erb :"/bloodpressurereadings/familymembers/show"
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

    delete "/bloodpressurereadings/familymembers/:id" do
        if logged_in?
            @bp = BloodPressureReading.find_by(id: params[:id])
            if @current_user.family_members.include?(@bp.family_member_id)
                @bp.destroy
                redirect to "/bloodpressurereadings/familymembers"
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