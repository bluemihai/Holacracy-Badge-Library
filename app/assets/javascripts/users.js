$(document).ready(function(){
    $('#users-table').DataTable({
        autoWidth: false,
        paging: false,
        searching: false,
        order: [1, 'asc'],
        orderClasses: true,
        columnDefs: [
            { targets: 'nosort', orderable: false}
        ],
        columns: [
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null
        ]
    });
});