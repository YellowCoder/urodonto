date_format = '%Y-%m-%dT%H:%M:%S'

json.id event.id
json.title "#{ event.title } - #{ event.patient.name }"
json.start event.start.strftime(date_format)
json.end event.end.strftime(date_format)

json.color event.color unless event.color.blank?
json.allDay event.all_day_event? ? true : false

json.update_url scheduler_path(event, method: :patch)
json.edit_url edit_scheduler_path(event)
json.show_url scheduler_path(event)