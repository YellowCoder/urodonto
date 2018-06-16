class EventsController < ApplicationController
  def index
    @events = Event.where(start: params[:start]..params[:end])
    # @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user

    if @event.save
      redirect_to events_path
    else
      render :new
    end
  end

  def scheduler
  end

  private

  def event_params
    params.require(:event).permit(
      :doctor_id,
      :patient_id,
      :title,
      :start,
      :end,
      :color
    )
  end
end