class EventsController < ApplicationController
  def index
    @events = Event.where(start: params[:start]..params[:end])
  end

  def new
    @event = Event.new
  end

  def scheduler
  end
end