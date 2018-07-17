module AppendFinancialRecord
  def self.extended(base)
    base.financial_record = self.build_financial_record(base)
  end

  private

  def self.build_financial_record(base)
    status = base.chargeable? ? 1 : 0
    FinancialRecord.new(user: base.user, status: status)
  end
end