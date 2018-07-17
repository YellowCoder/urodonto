# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.new(name: 'Adriano Tadao', email: 'adrianotadao@gmail.com', password: '123123')
user.save

10.times do
  Patient.create(name: Faker::Name.name)
end

10.times do
  payment_date = Faker::Date.between(2.months.ago, Date.today+3.months) + (1..23).to_a.sample.hours
  appointment_date = payment_date + (1..23).to_a.sample.hours - 10.days

  Appointment.create(
    financial_record: FinancialRecord.new(status: [0,1,2,3].sample, amount: rand(999), user: user, paid_at: payment_date),
    user: user,
    patient: Patient.all.sample,
    title: ['Orçamento', 'Manutenção', 'Limpeza', 'Restauração', 'Clareamento'].sample,
    start: appointment_date,
    end: appointment_date + 0.5.hours,
    color: Faker::Color.hex_color
  )
end