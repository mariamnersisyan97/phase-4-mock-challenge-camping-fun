class ActivitiesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        render json: Activity.all
    end

    def show
        render json: find_activity
    end

    def destroy
        activity = find_activity
        if activity 
            activity.signups.destroy_all
            # activity.delete
            activity.destroy
       # if Signup.where(activity_id: activity.id)
       #raise an error
       else
            render json: {error:"Activity not found"}, status: 404
       end
       
    end

    private
    
    def find_activity
        Activity.find_by_id(params[:id])
    end

    def render_not_found_response
        render json: { error: "Activity not found" }, status: :not_found
      end
end
