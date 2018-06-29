date_format = '%Y-%m-%dT%H:%M:%S'

json.id appointment.id
json.title "#{ appointment.title } - #{ appointment.patient.name }"
json.start appointment.start.strftime(date_format)
json.end appointment.end.strftime(date_format)

json.color appointment.color unless appointment.color.blank?
json.allDay appointment.all_day? ? true : false

json.update_url scheduler_path(appointment, method: :patch)
json.edit_url edit_scheduler_path(appointment)
json.show_url scheduler_path(appointment)