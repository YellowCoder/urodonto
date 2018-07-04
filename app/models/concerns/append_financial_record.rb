module AppendFinancialRecord
  def self.extended(base)
    base.financial_record = FinancialRecord.new(user: base.user)
  end
end