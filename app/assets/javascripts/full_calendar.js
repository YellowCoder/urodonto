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
    eventSources: [
      '/scheduler.json',
    ],
    select: function (start, end) {
      $.getScript('/events/new', function () {
        $('#event_date_range').val(moment(start).format("DD/MM/YYYY HH:mm") + ' - ' + moment(end).format("DD/MM/YYYY HH:mm"))
        date_range_picker();
        $('.start_hidden').val(moment(start).format('YYYY-MM-DD HH:mm'));
        $('.end_hidden').val(moment(end).format('YYYY-MM-DD HH:mm'));
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

    eventClick: function (event, jsEvent, view) {
      $.getScript(event.edit_url, function () {
        $('#event_date_range').val(moment(event.start).format("DD/MM/YYYY HH:mm") + ' - ' + moment(event.end).format("DD/MM/YYYY HH:mm"))
        date_range_picker();
        $('.start_hidden').val(moment(event.start).format('YYYY-MM-DD HH:mm'));
        $('.end_hidden').val(moment(event.end).format('YYYY-MM-DD HH:mm'));
      });
    }
  });
};
$(document).on('turbolinks:load', initialize_calendar);

