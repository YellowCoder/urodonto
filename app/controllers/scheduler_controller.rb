class SchedulerController < ApplicationController
  def index
    @events = Event.where(start: params[:start]..params[:end])
  end
end