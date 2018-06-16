var date_range_picker;
date_range_picker = function () {
  $('.date-range-picker').daterangepicker({
    timePicker: true,
    showDropdowns: true,
    locale: {
      format: "DD/MM/YYYY",
      separator: " - ",
      applyLabel: "Aplicar",
      cancelLabel: "Cancelar",
      fromLabel: "De",
      toLabel: "Até",
      customRangeLabel: "Personalizado",
      weekLabel: "W",
      daysOfWeek: [
        "Dom",
        "Seg",
        "Ter",
        "Qua",
        "Qui",
        "Sex",
        "Sab"
      ],
      monthNames: [
        "Janeiro",
        "Fevereiro",
        "Março",
        "Abril",
        "Maio",
        "Junho",
        "Julho",
        "Agosto",
        "Setembro",
        "Outubro",
        "Novembro",
        "Dezembro"
      ],
      firstDay: 1
    },
    opens: "right"
  }, function (start, end, label) {
    $('.start_hidden').val(start.format('YYYY-MM-DD HH:mm'));
    $('.end_hidden').val(end.format('YYYY-MM-DD HH:mm'));
  });
};
$(document).on('turbolinks:load', date_range_picker);
