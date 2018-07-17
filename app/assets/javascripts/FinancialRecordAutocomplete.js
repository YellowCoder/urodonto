var FinancialRecordAutocomplete = {
  start: function() {
    $input = $("[data-behavior='financial_record_autocomplete']")
    var field = $input.data('field')
    var options = {
      url: function(phrase) {
        return $input.data().autocompleteUrl + ".json?q=" + phrase;
      },
      adjustWidth: false,
      placeholder: 'Título da consulta ou nome do paciente...',
      getValue: "patient_name",
      list: {	
        match: {
          enabled: true
        },
      },
      requestDelay: 400,
      list: {
        onChooseEvent: function() {
          var appointmentId = $input.getSelectedItemData().id
          $("#" + field).val(appointmentId)

          var paymentDue = $input.getSelectedItemData().payment_due
          $('#payment_due').text(paymentDue)

          var paymentDelayed = $input.getSelectedItemData().delayed
          if (paymentDelayed) {
            $('#payment_due').css('color', 'red')
          }

          var titleDescription = $input.getSelectedItemData().title_description
          $('#financial_record_title').val(titleDescription)
          
          var appointmentDate = $input.getSelectedItemData().date
          $('#appointment_date').text(appointmentDate)

          var appointmentPrice = $input.getSelectedItemData().price
          $('#financial_record_amount').val(appointmentPrice)
        }
      },
      template: {
        type: "description",
        fields: {
          description: "description"
        }
      }
    }
    $input.easyAutocomplete(options)
  }
}