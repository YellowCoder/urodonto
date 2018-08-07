class FinancialRecordsController < ApplicationController
  include WithCurrentUser

  def index
    @financial_records = FinancialRecord.all.includes(appointment: :patient)
  end

  def new
    @financial_record = FinancialRecord.new
  end

  def new_for_appointment
    @financial_record = Appointment.find(params[:appointment_id]).build_financial_record
  end

  def edit
    @financial_record = FinancialRecord.find(params[:id])
  end

  def show
    @financial_record = FinancialRecord.find(params[:id])
  end

  def create
    @financial_record = FinancialRecord.new(financial_record_params)
    if with_current_user(@financial_record).save
      redirect_to financial_records_path
    else
      render :new
    end
  end
  
  def update
    @financial_record = FinancialRecord.find(params[:id])
    if @financial_record.update(financial_record_params)
      redirect_to financial_records_path
    else
      render :new
    end
  end

  def destroy
    @financial_record = FinancialRecord.find(params[:id])

    if @financial_record.destroy
      redirect_to financial_records_path
    else
      render :index
    end
  end

  private

  def financial_record_params
    params.require(:financial_record).permit(
      :appointment_id,
      :status,
      :title,
      :paid_at,
      :amount,
      :date,
      :observations
    )
  end
end