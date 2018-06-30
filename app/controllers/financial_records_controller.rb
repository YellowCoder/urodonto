class FinancialRecordsController < ApplicationController
  def index
    @financial_records = FinancialRecord.all
  end

  def new
    @financial_record = FinancialRecord.new
  end

  def show
    @financial_record = FinancialRecord.find(params[:id])
  end

  def create
    @financial_record = FinancialRecord.new(financial_record_params)
    @financial_record.user = current_user

    if @financial_record.save
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
      :amount,
      :date,
      :observations
    )
  end
end