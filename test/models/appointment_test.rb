require 'test_helper'

class AppointmentTest < ActiveSupport::TestCase
  test ":free payment status" do
    appointment = appointments(:free)
    assert_equal :free, appointment.payment_status
  end

  test ":paid if there is a financial record" do
    scheduled_appointment = appointments(:paid_scheduled)
    assert_equal :paid, scheduled_appointment.payment_status

    confirmed_appointment = appointments(:paid_confirmed)
    assert_equal :paid, confirmed_appointment.payment_status

    missed_appointment = appointments(:paid_missed)
    assert_equal :paid, missed_appointment.payment_status

    rescheduled_appointment = appointments(:paid_rescheduled)
    assert_equal :paid, rescheduled_appointment.payment_status
  end
end
