module AppointmentPayments
  NOT_CHARGEABLE_STATUSES = %w(scheduled missed rescheduled)
  CHARGEABLE_STATUSES = %w(confirmed)

  def payment_status
    return :free if !self.chargeable?
    return :overdue if payment_delayed? && self.financial_record.blank? && CHARGEABLE_STATUSES.include?(self.status)
    return :not_paid if self.chargeable? && self.financial_record.blank? && CHARGEABLE_STATUSES.include?(self.status) || NOT_CHARGEABLE_STATUSES.include?(self.status)
    :paid
  end

  def payment_delayed?
    return false if !CHARGEABLE_STATUSES.include?(self.status) || !chargeable || price == 0
    payment_due < DateTime.now
  end

  def price
    month_price&.price_cents || patient.fixed_price_cents
  end

  def month_price
    date = payment_due.beginning_of_month
    patient.patient_prices.find_by(date: date)
  end

  def paid?
    financial_record.present?
  end
end