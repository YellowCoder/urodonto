var OpenModal = function (options) {
  $('.modal').dialog({
    closeText: '',
    title: options.title,
    maxWidth:600,
    width: 600,
    close: function () {
      $(this).dialog('destroy').remove()
    }
  })
}