$(document).ready(function(){
    $('#holders-grid').DataTable({
        autoWidth: false,
        ordering: false,
        searching: false,
        pageLength: 10,
        lengthMenu: [ [10, 15, 20, 25, -1], [10, 15, 20, 25, "All"] ],
        language: { lengthMenu: "Display _MENU_ Badges" }
    });

    $('#users-table').DataTable({
        autoWidth: false,
        paging: false,
        searching: false,
        order: [1, 'asc'],
        orderClasses: true,
        columnDefs: [
            { targets: 'nosort', orderable: false}
        ]
    });
});