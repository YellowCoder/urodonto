var initialize_calendar;
initialize_calendar = function () {
  var calendar = $('.full_calendar');
  calendar.fullCalendar({
    header: {
      right: 'today prev,next,month,agendaWeek agendaDay,listWeek,listMonth'
    },
    buttonText: {
      agendaDay: 'Lista do Dia',
      listWeek: 'Lista da Semana',
      listMonth: 'Lista do Mês'
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
    eventResize: function (appointment, delta, revertFunc) {
      var appointment_data
      if (appointment.allDay) {
        appointment_data = {
          appointment: {
            id: appointment.id,
            start: moment(appointment.start.format()).startOf('day'),
            end: moment(appointment.start.format()).endOf('day')
          }
        };
      } else {
        appointment_data = {
          appointment: {
            id: appointment.id,
            start: appointment.start.format(),
            end: appointment.end.format()
          }
        };
      }

      $.ajax({
        url: appointment.update_url,
        data: appointment_data,
        type: 'PATCH'
      });
    },
    select: function (start, end, jsEvent, view) {
      if (view.name === 'month') {
        return
      }
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

        $('#appointment_start_3i').val(startDay)
        $('#appointment_start_2i').val(startMonth)
        $('#appointment_start_1i').val(startYear)
        $('#appointment_start_4i').val(startHour)
        $('#appointment_start_5i').val(startMinute)

        $('#appointment_end_3i').val(endDay)
        $('#appointment_end_2i').val(endMonth)
        $('#appointment_end_1i').val(endYear)
        $('#appointment_end_4i').val(endHour)
        $('#appointment_end_5i').val(endMinute)

        OpenModal({ title: 'Novo Agendamento' })
        
        $input = $("[data-behavior='patients_autocomplete']")
        var field = $input.data('field')
        var options = {
          url: function(phrase) {
            return $input.data().autocompleteUrl + ".json?q=" + phrase;
          },
          getValue: "name",
          list: {	
            match: {
              enabled: true
            }
          },
          requestDelay: 400,
          list: {
            onChooseEvent: function() {
              var patientId = $input.getSelectedItemData().id
              $("#" + field).val(patientId)
            }
          }
        }
        $input.easyAutocomplete(options)
      });

      calendar.fullCalendar('unselect');
    },

    eventDrop: function (appointment, delta, revertFunc) {
      var appointment_data
      if (appointment.allDay) {
        var start = 
        appointment_data = {
          appointment: {
            id: appointment.id,
            start: appointment.start.format('YYYY-MM-DD 00:00'),
            end: appointment.start.format('YYYY-MM-DD 00:00')
          }
        };
      } else {
        if (!appointment.end) {
          appointment.end = appointment.start.clone().add(1, 'hour')
        }

        appointment_data = {
          appointment: {
            id: appointment.id,
            start: appointment.start.format(),
            end: appointment.end.format()
          }
        };
      }

      $.ajax({
        url: appointment.update_url,
        data: appointment_data,
        type: 'PATCH'
      });
    },

    eventClick: function (appointment) {
      $.getScript(appointment.show_url, function () {
        OpenModal({ title: 'Detalhes do Agendamento' })
      })
    },

    dayClick: function (date, jsEvent, view) {
      if (view.name === "month") {
        calendar.fullCalendar('gotoDate', date)
        calendar.fullCalendar('changeView', 'agendaDay')
      }
    }
  });
};
$(document).on('turbolinks:load', initialize_calendar);

