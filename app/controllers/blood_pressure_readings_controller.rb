class BloodPressureReadingsController < ApplicationController

    get "/bloodpressurereadings" do
        if logged_in?
            @bps = @current_user.blood_pressure_readings.order(date: :desc)
            if @bps.user_id == @current_user.id || @current_user.family_members.include?(@bps.family_member_id)
                erb :"/bloodpressurereadings/index"
            else
                flash[:alert] = "You can only view yours or your family member's blood pressure readings."
                redirect to "/users/hompage"
            end
        else
            flash[:alert] = "You must be logged in to view your blood pressure readings."
            redirect to "/login"
        end
    end

    get "/bloodpressurereadings/new" do
        if logged_in?
            erb :"/bloodpressurereadings/new"
        else
            flash[:alert] = "You must be logged in to submit a new blood pressure reading."
            redirect to "/login"
        end
    end

    post "/bloodpressurereadings" do
        @bp = BloodPressureReading.create(params)
        redirect to "/bloodpressurereadings/#{@bp.id}"
    end

    get "/bloodpressurereadings/:id/edit" do
        if logged_in?
            @bp = BloodPressureReading.find_by(id: params[:id])
            if @bp.user_id == @current_user.id || @current_user.family_members.include?(@bp.family_member_id)
                erb :"/bloodpressurereadings/edit"
            else
                flash[:alert] = "You can only edit the blood pressure readings that belong to either you or your family members."
                redirect to "/bloodpressurereadings"
            end
        else
            flash[:alert] = "You must be logged in to edit any of your blood pressure readings."
            redirect to "/login"
        end       
    end

    patch "/bloodpressurereadings/:id" do
        @bp = BloodPressureReading.find_by(id: params[:id])
        if @bp.user_id == @current_user.id || @current_user.family_members.include?(@bp.family_member_id)
            @bp.update(date: params[:date], time: params[:time], systolic_reading: params[:systolic_reading], diastolic_reading: params[:diastolic_reading], pulse: params[:pulse], device_used: [:device_used], site_used: params[:site_used], notes: params[:notes])
            redirect to "/bloodpressurereadings/#{@bp.id}"
        else
            flash[:alert] = "You can only edit the blood pressure readings that belong to either you or your family members."
            redirect to "/bloodpressurereadings"
        end
    end

    get "/bloodpressurereadings/:id" do
        if logged_in?
            @bp = BloodPressureReading.find_by(id: params[:id])
            if @bp.user_id == @current_user.id || @current_user.family_members.include?(@bp.family_member_id)
                erb :"/bloodpressurereadings/show"
            else
                flash[:alert] = "You can only view yours or your family member's blood pressure readings."
                redirect to "/users/hompage"
            end
        else
            flash[:alert] = "You must be logged in to view your blood pressure readings."
            redirect to "/login"
        end
    end

    delete "/bloodpressurereadings/:id" do
        if logged_in?
            if @bp.user_id == @current_user.id || @current_user.family_members.include?(@bp.family_member_id)
                @bp = BloodPressureReading.find(params[:id])
                @bp.destroy
                redirect to "/bloodpressurereadings"
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