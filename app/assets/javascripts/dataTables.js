var InitializeDataTables = function(options) {
  var dataTable = $('#datatable').DataTable({
    order: options.order,
    pageLength: 25,
    language: {
      url: '//cdn.datatables.net/plug-ins/1.10.19/i18n/Portuguese-Brasil.json'
    }
  });
  document.addEventListener('turbolinks:before-cache', function() {
    if (dataTable !== null) {
      dataTable.destroy()
      dataTable = null
    }
  });
}