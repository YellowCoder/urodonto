var initialize_calendar;
initialize_calendar = function () {
  var calendar = $('.full_calendar');
  calendar.fullCalendar({
    header: {
      left: 'prev,next today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay'
    },
    locale: 'pt-br',
    selectable: true,
    selectHelper: true,
    editable: true,
    eventLimit: true,
    defaultView: 'agendaWeek',
    eventSources: [
      '/scheduler.json',
    ],
    eventResize: function (event, delta, revertFunc) {
      var event_data
      if (event.allDay) {
        event_data = {
          event: {
            id: event.id,
            start: moment(event.start.format()).startOf('day'),
            end: moment(event.start.format()).endOf('day')
          }
        };
      } else {
        event_data = {
          event: {
            id: event.id,
            start: event.start.format(),
            end: event.end.format()
          }
        };
      }

      $.ajax({
        url: event.update_url,
        data: event_data,
        type: 'PATCH'
      });
    },
    select: function (start, end) {
      $.getScript('/events/new', function () {
        date_range_picker();

        $('.date_picker').pickadate().pickadate('picker').set('select', moment(start).format("YYYY-MM-DD"), { format: 'yyyy-mm-dd' })
        $('.time_picker_start').pickatime('picker').set('select', moment(start).format("HH-mm"), { format: 'H-i' })
        $('.time_picker_end').pickatime('picker').set('select', moment(end).format("HH-mm"), { format: 'H-i' })

        $('.modal').dialog({
          close: function() {
            $(this).dialog('destroy').remove()
          }
        })
        $("input[data-autocomplete]").each(function () {
          var url = $(this).data('autocomplete')
          var field = $(this).data('field')
          $(this).autocomplete({
            source: url,
            select: function (event, ui) {
              $("#" + field).val(ui.item.id)
            },
            change: function (event, ui) {
              if (!ui.item) {
                $("#" + field).val(null)
              }
            }
          })
        })
      });

      calendar.fullCalendar('unselect');
    },

    eventDrop: function (event, delta, revertFunc) {
      var event_data
      if (event.allDay) {
        var start = 
        event_data = {
          event: {
            id: event.id,
            start: event.start.format('YYYY-MM-DD 00:00'),
            end: event.start.format('YYYY-MM-DD 00:00')
          }
        };
      } else {
        if (!event.end) {
          event.end = event.start.clone().add(1, 'hour')
        }

        event_data = {
          event: {
            id: event.id,
            start: event.start.format(),
            end: event.end.format()
          }
        };
      }

      $.ajax({
        url: event.update_url,
        data: event_data,
        type: 'PATCH'
      });
    },

    eventClick: function (event, jsEvent, view) {
      $.getScript(event.show_url, function () {
        // $('#date_range').val(moment(event.start).format("DD/MM/YYYY"))
        // date_range_picker();

        // $('#start_time').val(moment(event.start).format('YYYY-MM-DD HH:mm'));
        // $('.end_hidden').val(moment(event.end).format('YYYY-MM-DD HH:mm'));
        $('.modal').dialog({
          close: function () {
            $(this).dialog('destroy').remove()
          }
        })
      });
    }
  });
};
$(document).on('turbolinks:load', initialize_calendar);

