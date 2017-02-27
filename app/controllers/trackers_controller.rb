# frozen_string_literal: true

class TrackersController < OpenReadController
  before_action :set_tracker, only: [:show, :update, :destroy]

  # GET /trackers
  def index
    @trackers = current_user.trackers
    render json: @trackers
  end

  # GET /trackers/1
  def show
    render json: @tracker
  end

  # POST /trackers
  def create
    @tracker = current_user.trackers.build(tracker_params)

    if @tracker.save
      render json: @tracker, status: :created
    else
      render json: @tracker.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /trackers/1
  def update
    if @tracker.update(tracker_params)
      render json: @tracker
    else
      render json: @tracker.errors, status: :unprocessable_entity
    end
  end

  # DELETE /trackers/1
  def destroy
    @tracker.destroy
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tracker
    @tracker = Tracker.where(id: params[:id], user: current_user).take
  end

  # Only allow a trusted parameter "white list" through.
  def tracker_params
    params.require(:tracker).permit(:first_name, :last_name, :grade,
                   :comments)
  end
end
