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
      $.getScript('/scheduler/new', function () {
        var startDay = start.date()
        var startMonth = start.month() + 1
        var startYear = start.year()
        var startHour = start.hour()
        if (startHour < 10) {
          startHour = '0' + startHour
        }
        var startMinute = start.minute()
        if (startMinute === 0) {
          startMinute = '00'
        }

        var endDay = end.date()
        var endMonth = end.month() + 1
        var endYear = end.year()
        var endHour = end.hour()
        if (endHour < 10) {
          endHour = '0' + endHour
        }
        var endMinute = end.minute()
        if (endMinute === 0) {
          endMinute = '00'
        }

        $('#event_start_3i').val(startDay)
        $('#event_start_2i').val(startMonth)
        $('#event_start_1i').val(startYear)
        $('#event_start_4i').val(startHour)
        $('#event_start_5i').val(startMinute)

        $('#event_end_3i').val(endDay)
        $('#event_end_2i').val(endMonth)
        $('#event_end_1i').val(endYear)
        $('#event_end_4i').val(endHour)
        $('#event_end_5i').val(endMinute)


        $('.modal').dialog({
          title: 'Novo agendamento',
          maxWidth:600,
          maxHeight: 550,
          width: 600,
          height: 550,
          closeText: '',
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
        $('.modal').dialog({
          closeText: '',
          title: 'Detalhes do Agendamento',
          maxWidth:600,
          maxHeight: 550,
          width: 600,
          height: 360,
          close: function () {
            $(this).dialog('destroy').remove()
          }
        })
      });
    }
  });
};
$(document).on('turbolinks:load', initialize_calendar);

