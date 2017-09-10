class JourneysController < ApplicationController
  include GoogleMapsDirections
  before_action :set_journey, only: [:show, :end_journey, :destroy]

  # GET /journeys
  def index
    @journeys = Journey.all

    render json: @journeys
  end

  # GET /journeys/1
  def show
    render json: @journey
  end

  # POST /journeys
  def create
    @journey = Journey.new(journey_params)

    if @journey.save
      render json: @journey, status: :created, location: @journey
    else
      render json: @journey.errors, status: :unprocessable_entity
    end
  end

  # POST /journeys/1/end
  def end_journey
    destination = Location.find_by_id(params[:destination_id])
    return render json: 'No destination found', status: :unprocessable_entity if !destination
    @journey.destination = destination
    @journey.end_time = Time.now
    @journey.google_directions_data = self.fetch_google_directions(@journey.origin, destination)

    if @journey.save
      render json: @journey
    else
      render json: @journey.errors, status: :unprocessable_entity
    end
  end

  # DELETE /journeys/1
  def destroy
    @journey.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_journey
      @journey = Journey.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def journey_params
      params.require(:journey).permit(:origin_id, :destination_id)
    end
end
