$.fn.clear_form_errors = function(){
  this.find('.form-group').removeClass('has-error')
  this.find('span.help-block').remove()
}

$.fn.clear_form_fields = function() {
  this.find(':input')
      .not(':button, :submit, :reset, :hidden')
      .val('')
      .removeAttr('checked')
      .removeAttr('selected')
}

$.fn.render_form_errors = function(model_name, errors){
  form = this
  this.clear_form_errors()

  $.each(errors, function(field, messages){
    input = form.find('input, select, textarea').filter(function() {
      name = $(this).attr('name')
      if (name) {
        return name.match(new RegExp(model_name + '\\[' + field + '\\(?'))
      }
    })[0]
    $('.form-actions :submit').addClass('has-error')
    $(input).parent().append('<span class="help-block">' + $.map(messages, function(m){ return m.charAt(0).toUpperCase() + m.slice(1)}).join('<br />') + '</span>')
  })
}