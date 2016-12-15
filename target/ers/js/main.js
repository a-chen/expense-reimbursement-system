$( document ).ready(function() {
    //Initialize data table
    $(document).ready( function () {
        $('#example').DataTable();
    } );

    $(document).on('click','.edit_row a',function() {
        $(this).closest('tr').find('select')
            .prop('disabled', function(_, prop){ return !prop});
    });


    /**
     * Upon change of select box for Reimbursement status or type,
     * sends AJAX post request to change to alter database data
     */
    $('.reimb_status').change(function(){

        reimb_id = $(this).closest('tr').find('.reimb_id').text();
        reimb_status = $(this).closest('tr').find("select[name='reimb_status']").val();

        console.log('Reimbursement ' + reimb_id + ':Status changed to ' + reimb_status);

        var statusObj = {status:reimb_status};
        var reimbursementObj = JSON.stringify({id:reimb_id, status:statusObj});
        $.ajax({
            method:"POST",
            url:"updateStatus.do",
            data: reimbursementObj,
            success: function (data) {
                
            }
        });
    });

    /**
     * Upon change of select box for Reimbursement status or type,
     * sends AJAX post request to change to alter database data
     */
    $('.reimb_type').change(function(){

        reimb_id = $(this).closest('tr').find('.reimb_id').text();
        reimb_type = $(this).closest('tr').find("select[name='reimb_type']").val();

        console.log('Reimbursement ' + reimb_id + ':Type changed to ' + reimb_type);

        var typeObj = {type:reimb_type};
        var reimbursementObj = JSON.stringify({id:reimb_id, type:typeObj});
        $.ajax({
            method:"POST",
            url:"updateType.do",
            data: reimbursementObj
        });
    });
});


