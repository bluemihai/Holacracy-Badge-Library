$(document).ready(function(){
    $('#badges-table').DataTable({
        searching: false,
        paging: false,
        columnDefs: [
            { targets: 'nosort', orderable: false}
        ],
        order: [4, 'desc'],
        // pageLength: -1,
        // lengthMenu: [ [10, 15, 20, 25, -1], [10, 15, 20, 25, "All"] ],
        // language: { lengthMenu: "Display _MENU_ Badges" }
    });
});