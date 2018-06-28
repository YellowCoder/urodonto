# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.new(name: 'Adriano Tadao', email: 'adrianotadao@gmail.com', password: '123123')
user.save

doctor = Doctor.new(active: true, name: 'Mônica')
doctor.save

patient = Patient.new(name: 'Adriano Tadao')
patient.save

patient2 = Patient.new(name: 'Guilherme de Morais')
patient2.save

Event.create(
  user: user, 
  patient: patient, 
  doctor: doctor, 
  title: 'Orçamento',
  start: DateTime.now,
  end: DateTime.now + 0.5.hours,
  color: '#429cb6'
)

Event.create(
  user: user, 
  patient: patient2, 
  doctor: doctor, 
  title: 'Retorno',
  start: DateTime.now + 2.hours,
  end: DateTime.now + 2.5.hours,
  color: '#495057'
)