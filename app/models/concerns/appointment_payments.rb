module AppointmentPayments
  NOT_CHARGEABLE_STATUSES = %w(scheduled missed rescheduled)
  CHARGEABLE_STATUSES = %w(confirmed)

  def payment_status
    return :free if !self.chargeable? || NOT_CHARGEABLE_STATUSES.include?(self.status) && self.financial_record.blank?
    return :overdue if payment_delayed? && self.financial_record.blank? && CHARGEABLE_STATUSES.include?(self.status)
    return :not_paid if self.chargeable? && self.financial_record.blank? && CHARGEABLE_STATUSES.include?(self.status)
    :paid
  end

  def payment_delayed?
    return false unless chargeable
    payment_due < DateTime.now
  end
end