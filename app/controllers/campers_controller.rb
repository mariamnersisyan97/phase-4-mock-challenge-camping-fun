class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        render json: Camper.all
    end

    def show
        render json: find_camper, serializer: CamperWithActivitiesSerializer
    end

    def create
        camper = Camper.create!(camper_param)
        render json: camper, status: :created
    end

    private

    def find_camper
        Camper.find(params[:id])
    end

    def camper_param
        params.permit(:name, :age)
    end
     
    def render_not_found_response
        render json: { error: "Camper not found" }, status: :not_found
    end

    def render_unprocessable_entity_response(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
      end
end
