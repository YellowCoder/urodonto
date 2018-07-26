class OverviewsController < ApplicationController
  def index
    @overview_date = Overview.new(overviews_params)
    @grouped_months = @overview_date.groupped_months
    @patients_list = @overview_date.patients_list
  end

  private

  def overviews_params
    return if params[:overview].blank?
    params.require(:overview).permit(
      :initial_date,
      :end_date
    )
  end
end