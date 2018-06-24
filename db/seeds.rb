# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.new(email: 'adrianotadao@gmail.com', password: '123123')
user.save

doctor = Doctor.new(active: true, name: 'Mônica')
doctor.save

patient = Patient.new(name: 'Adriano')
patient.save

Patient.new(name: 'Bart').save

event = Event.new(
  user: user, 
  patient: patient, 
  doctor: doctor, 
  title: 'Retorno',
  start: DateTime.now,
  end: DateTime.now + 2.hours
)
event.save