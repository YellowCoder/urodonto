class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    
    unless @event.save
      render :new
    end
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    # if @event.update(event_params)
    #   redirect_to events_path
    # else
    #   render :new
    # end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    # redirect_to events_path
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