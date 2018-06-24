json.array! @events do |event|
  date_format = '%Y-%m-%dT%H:%M:%S'
  json.id event.id
  json.title "#{ event.title } - #{ event.patient.name }"
  json.start event.start.strftime(date_format)
  json.end event.end.strftime(date_format)
  json.color event.color unless event.color.blank?
  json.allDay event.all_day_event? ? true : false
  json.created_at event.created_at
  json.updated_at event.updated_at
  json.update_url event_path(event, method: :patch)
  json.edit_url edit_event_path(event)
  json.show_url event_path(event)
end