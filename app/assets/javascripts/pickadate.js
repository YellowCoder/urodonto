var pickADate;
pickADate = function () {
  var datePicker = $('.date_picker').pickadate({
    format: 'dd/mm/yyyy',
    onStart: function() {
      var date = new Date()
      this.set('select', [date.getFullYear(), date.getMonth(), date.getDate()]);
    },
    onSet: function(context) {
      var selectedDate = this.get("select", "yyyy-mm-dd")

      var currentStartTime = moment($('.start_hidden').val()).format('HH:mm')
      var newStartTime = selectedDate + ' ' + currentStartTime

      var currentEndTime = moment($('.end_hidden').val()).format('HH:mm')
      var newEndTime = selectedDate + ' ' + currentEndTime
      
      $('.start_hidden').val(newStartTime)
      $('.end_hidden').val(newEndTime)
    }
  })

  var startTimePicker = $('.time_picker_start').pickatime({
    format: 'H:i',
    formatLabel: '<b>H</b>:i',
    onStart: function () {
      var date = new Date()
      this.set('select', date.getHours() + '-00', { format: 'hh-i' })
    },
    onSet: function(context) {
      var startDate = formatedDate(this.get('select'), datePicker.data('pickadate').get('select'))
      $('.start_hidden').val(startDate)
    }
  })

  var endTimePicker = $('.time_picker_end').pickatime({
    format: 'H:i',
    formatLabel: '<b>H</b>:i',
    onStart: function () {
      var date = new Date()
      this.set('select', date.getHours() + '-30', { format: 'hh-i' })
    },
    onSet: function (context) {
      var endDate = formatedDate(this.get('select'), datePicker.data('pickadate').get('select'))
      $('.end_hidden').val(endDate)
    }
  })
};

var formatedDate = function(timer, date) {
  var day = date.date
  var month = date.month
  var year = date.year
  var hour = timer.hour
  var minutes = timer.mins

  var finalDate = new Date(year, month, day, hour, minutes)
  return moment(finalDate).format('YYYY-MM-DD HH:mm')
}

$(document).on('turbolinks:load', pickADate);