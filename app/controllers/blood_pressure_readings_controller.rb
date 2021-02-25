class BloodPressureReadingsController < ApplicationController

    get "/bloodpressurereadings" do
        if logged_in?
            @bps = @current_user.blood_pressure_readings.order(date: :desc)
            erb :"/bloodpressurereadings/index"
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
            @bp = BloodPressureReading.find(params[:id])
            erb :"/bloodpressurereadings/edit"
        else
            flash[:alert] = "You must be logged in to edit any of your blood pressure readings."
            redirect to "/login"
        end       
    end

    patch "/bloodpressurereadings/:id" do
        @bp = BloodPressureReading.find(params[:id])
        @bp.update(params)
        @bp.save
        redirect to "/bloodpressurereadings/#{@bp.id}"
    end

    get "/bloodpressurereadings/:id" do
        if logged_in?
            @bp = BloodPressureReading.find(params[:id])
            erb :"/bloodpressurereadings/show"
        else
            flash[:alert] = "You must be logged in to view your blood pressure readings."
            redirect to "/login"
        end
    end

    delete "/bloodpressurereadings/:id" do
        if logged_in?
            @bp = BloodPressureReading.find(params[:id])
            @bp.destroy
            redirect to "/bloodpressurereadings"
        else
            flash[:alert] = "You must be logged in to delete any of your blood pressure readings."
            redirect to "/login"
        end
    end

end