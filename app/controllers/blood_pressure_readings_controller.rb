class BloodPressureReadingsController < ApplicationController

    get "/bloodpressurereadings/:slug/all" do 
        @user = User.find_by_matched_slug(params[:slug])
        if logged_in?
            if @user &&  @user.id == current_user.id 
                @bps = current_user.blood_pressure_readings.order(:date, :time)
                erb :"/bloodpressurereadings/index"
            else
                flash[:alert] = "You can only view the blood pressure readings that belong to you."
                redirect to "/users/#{current_user.username}"
            end
        else
            flash[:alert] = "You must be logged in to view your blood pressure readings."
            redirect to "/login"
        end
    end

    get "/bloodpressurereadings/:slug/new" do
        @user = User.find_by_matched_slug(params[:slug])
        if logged_in?
            if @user.id == current_user.id 
                erb :"/bloodpressurereadings/new"
            else
                flash[:alert] = "You can only add a new blood pressure reading to your own blood pressure log."
                redirect to "/users/#{current_user.username}"
            end
        else
            flash[:alert] = "You must be logged in to submit a new blood pressure reading."
            redirect to "/login"
        end
    end

    post "/bloodpressurereadings/:slug" do
        user = User.find_by_matched_slug(params[:slug])
        if logged_in?
            if user.id == current_user.id 
                bp = BloodPressureReading.new(params.except("slug"))
                bp.user_id = current_user.id 
                bp.save
                redirect to "/bloodpressurereadings/#{bp.id}"
            else
                flash[:alert] = "You can only add a new blood pressure reading to your own blood pressure reading log."
                redirect to "/bloodpressurereadings/#{current_user.username}/all"
            end
        else
            flash[:alert] = "You must be logged in to submit a new blood pressure reading."
            redirect to "/login"
        end
    end

    get "/bloodpressurereadings/:id/edit" do
        if logged_in?
            @bp = BloodPressureReading.find_by(id: params[:id])
            if @bp.user_id == current_user.id
                erb :"/bloodpressurereadings/edit"
            else
                flash[:alert] = "You can only edit the blood pressure readings that belong to you."
                redirect to "/bloodpressurereadings/#{current_user.username}/all"
            end
        else
            flash[:alert] = "You must be logged in to edit any of your blood pressure readings."
            redirect to "/login"
        end       
    end

    patch "/bloodpressurereadings/:id" do
        bp = BloodPressureReading.find_by(id: params[:id])
        if bp.user_id == current_user.id 
            bp.notes = params[:notes] unless params[:notes].blank?
            bp.save 
            bp.update(date: params[:date], time: params[:time], systolic_reading: params[:systolic_reading], diastolic_reading: params[:diastolic_reading], pulse: params[:pulse], device_used: params[:device_used], site_used: params[:site_used]) 
            flash[:message] = "Your blood pressure reading information has been updated successfully!"
            redirect to "/bloodpressurereadings/#{bp.id}"
        else
            flash[:alert] = "You can only edit the blood pressure readings that belong to you."
            redirect to "/bloodpressurereadings/#{current_user.username}/all"
        end
    end

    get "/bloodpressurereadings/:id" do
        if logged_in?
            @bp = BloodPressureReading.find_by(id: params[:id])
            if @bp.user_id == current_user.id 
                erb :"/bloodpressurereadings/show"
            else
                flash[:alert] = "You can only view the blood pressure readings that belong to you."
                redirect to "/users/#{current_user.username}"
            end
        else
            flash[:alert] = "You must be logged in to view your blood pressure readings."
            redirect to "/login"
        end
    end

    delete "/bloodpressurereadings/:id" do
        number = params[:id]
        session[bp: number] = 1 unless session[bp: number] == 2
        if logged_in?
            bp = BloodPressureReading.find_by(id: params[:id])
            if bp.user_id == current_user.id && session[bp: number] == 1
                session[bp: number] = 2
                flash[:warning] = "Are you sure you want to delete the blood pressure reading, #{bp.systolic_reading} / #{bp.diastolic_reading} from #{bp.date}?" 
                redirect to "/bloodpressurereadings/#{current_user.username}/all"
            elsif bp.user_id == current_user.id && session[bp: number] == 2
                bp.destroy
                flash[:notice] = "Your blood pressure reading, #{bp.systolic_reading} / #{bp.diastolic_reading} from #{bp.date}, has been deleted from your account."
                redirect to "/bloodpressurereadings/#{current_user.username}/all"
            else
                flash[:alert] = "You can only delete the blood pressure readings that belong to you."
                redirect to "/bloodpressurereadings/#{current_user.username}/all"
            end
        else
            flash[:alert] = "You must be logged in to delete any of your blood pressure readings."
            redirect to "/login"
        end
    end

end