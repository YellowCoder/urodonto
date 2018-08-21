var initialize_calendar;
var calendar;

var fillUpDate = function(date, field) {
  var day = date.date()
  var month = date.month() + 1
  var year = date.year()
  var hour = date.hour()
  var minute = date.minute()
  if (hour < 10) {
    hour = '0' + hour
  }
  if (minute === 0) {
    minute = '00'
  }

  $('#appointment_' + field + '_3i').val(day)
  $('#appointment_' + field + '_2i').val(month)
  $('#appointment_' + field + '_1i').val(year)
  $('#appointment_' + field + '_4i').val(hour)
  $('#appointment_' + field + '_5i').val(minute)
}

var onResize = function(appointment) {
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
}

var onSelect = function(start, end, jsEvent, view) {
  if (view.name === 'month') {
    return
  }
  $.getScript('/scheduler/new', function () {
    fillUpDate(start, 'start')
    fillUpDate(end, 'end')
    
    OpenModal({ title: 'Novo Agendamento' })
    
    $input = $("[data-behavior='patients_autocomplete']")
    var field = $input.data('field')
    var options = {
      url: function(phrase) {
        return $input.data().autocompleteUrl + ".json?q=" + phrase;
      },
      placeholder: 'Nome do paciente...',
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
}

var eventDrop = function(appointment) {
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
}

var eventClick = function(appointment) {
  $.getScript(appointment.show_url, function () {
    OpenModal({ title: 'Detalhes do Agendamento' })
  })
}

var dayClick = function (date, jsEvent, view) {
  if (view.name === "month") {
    calendar.fullCalendar('gotoDate', date)
    calendar.fullCalendar('changeView', 'agendaDay')
  }
}

initialize_calendar = function () {
  calendar = $('.full_calendar')
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
      '/agenda.json',
    ],
    eventResize: onResize,
    select: onSelect,
    eventDrop: eventDrop,
    eventClick: eventClick,
    dayClick: dayClick
  });
};
$(document).on('turbolinks:load', initialize_calendar);

