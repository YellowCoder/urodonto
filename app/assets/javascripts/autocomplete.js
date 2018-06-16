var initializaAutocomplete;
initializaAutocomplete = function () {
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
};
$(document).on('turbolinks:load', initializaAutocomplete);
