var OpenModal = function (options) {
  $('.modal').dialog({
    closeText: '',
    title: options.title,
    maxWidth:600,
    maxHeight: 550,
    width: 600,
    height: 550,
    close: function () {
      $(this).dialog('destroy').remove()
    }
  })
}