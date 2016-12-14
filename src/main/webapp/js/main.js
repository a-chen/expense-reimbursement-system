$( document ).ready(function() {
    //Initialize data table
    $(document).ready( function () {
        $('#example').DataTable();
    } );

    $(document).on('click','.edit_row a',function() {
        $(this).closest('tr').find('select')
            .prop('disabled', function(_, prop){ return !prop});
    });

    //@todo
    $("#reimb_table_submit").click(function(){
        $.post("reimbursementTable.do",
            {
                name: "Donald Duck",
                city: "Duckburg"
            },
            function(data, status){
                console.log("Data: " + data + "\nStatus: " + status);
            });
    });
});


