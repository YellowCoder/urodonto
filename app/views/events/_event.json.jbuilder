date_format = event.all_day_event? ? '%d-%m-%Y' : '%d-%m-%YT%H:%M:%S'

json.id "event_#{event.id}"
json.title event.title
json.start event.start.strftime(date_format)
json.end event.end.strftime(date_format)

json.color event.color unless event.color.blank?
json.allDay event.all_day_event? ? true : false

json.update_url event_path(event, method: :patch)
json.edit_url edit_event_path(event)
