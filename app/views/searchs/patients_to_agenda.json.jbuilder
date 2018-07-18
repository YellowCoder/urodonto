json.array! @patients do |patient|
  json.id patient.id
  json.name patient.name
end