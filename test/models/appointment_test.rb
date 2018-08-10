require 'test_helper'

class AppointmentTest < ActiveSupport::TestCase
  test ":free if chargeable == false" do
    appointment = appointments(:free)
    assert_equal :free, appointment.payment_status
    assert_nil appointment.financial_record
  end

  test ":paid if status is scheduled and has financial record" do
    scheduled_appointment = appointments(:paid_scheduled)
    assert_equal :paid, scheduled_appointment.payment_status
  end

  test ":paid if status is confirmed and has financial record" do
    confirmed_appointment = appointments(:paid_confirmed)
    assert_equal :paid, confirmed_appointment.payment_status
  end

  test ":paid if status is missed and has financial record" do
    missed_appointment = appointments(:paid_missed)
    assert_equal :paid, missed_appointment.payment_status
  end

  test ":paid if status is rescheduled and has financial record" do
    rescheduled_appointment = appointments(:paid_rescheduled)
    assert_equal :paid, rescheduled_appointment.payment_status
  end

  test ":paid if there is financial record" do
    rescheduled_appointment = appointments(:paid_not_chargeable)
    assert_equal :paid, rescheduled_appointment.payment_status
  end

  test "is payment_delayed? if it is confirmed" do
    appointment = appointments(:overdue_confirmed)
    assert_equal true, appointment.payment_delayed?
  end

  test "is not paylemnt_delayed? if it is not chargeable?" do
    appointment = appointments(:overdue_free)
    assert_equal false, appointment.payment_delayed?
  end

  test "is not payment_delayed? if the value is zero" do
    appointment = appointments(:overdue_confirmed_zero_value)
    assert_equal false, appointment.payment_delayed?
  end

  test "is not payment_delayed? if it is a missed appointment" do
    appointment = appointments(:overdue_missed)
    assert_equal false, appointment.payment_delayed?
  end

  test "is not payment_delayed? if it is a rescheduled appointment" do
    appointment = appointments(:overdue_rescheduled)
    assert_equal false, appointment.payment_delayed?
  end

  test "is not payment_delayed? if it is a scheduled appointment" do
    appointment = appointments(:overdue_scheduled)
    assert_equal false, appointment.payment_delayed?
  end

  test "is not payment_delayed? if it is a confirmed and not chargeable appointment" do
    appointment = appointments(:overdue_confirmed_and_free)
    assert_equal false, appointment.payment_delayed?
  end

  test "is not payment_delayed? if the payment_due is greater than Today" do
    appointment = appointments(:confirmed_not_overdue)
    assert_equal false, appointment.payment_delayed?
  end
end