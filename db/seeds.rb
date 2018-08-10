User.create(name: 'Adriano User', email: 'adriano@gmail.com', password: '123123')
User.create(name: 'Adriano Admin', email: 'admin@gmail.com', password: '123123', role: :admin)

10.times do
  patient = Patient.new(name: Faker::Name.name, fixed_price_cents: 100)
  patient.save
end

Patient.all.each do |patient|
  appointment_date = Faker::Date.between(2.months.ago, Date.today + 3.months) + (8..18).to_a.sample.hours
  payment_date = appointment_date + 1.month

  patient.appointments.create(
    user: User.all.sample,
    title: ['Orçamento', 'Manutenção', 'Limpeza', 'Restauração', 'Clareamento'].sample,
    start: appointment_date,
    end: appointment_date + 0.5.hours,
    color: Faker::Color.hex_color,
    payment_due: appointment_date.end_of_month
  )
end