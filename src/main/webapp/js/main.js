$( document ).ready(function() {

    //Initialize data table
    $(document).ready( function () {
        $('#reimb_table').DataTable({
            "lengthMenu": [ 50, 100 ]
        });
    });

    //enable bootstrap popovers
    $('[data-toggle="popover"]').popover();
    //end intialization

    /**
     * set focus to first field
     *  upon launching modal
     */
    $('#reimbursementModal').on('shown.bs.modal', function () {
        $('#reimb_submit_description').focus();
    });

    /**
     * Adds Reimbursement to database
     */
    function addReimbursement() {
        console.log("Reimbursment submit clicked");

        //extract data from form
        amount = $("#reimb_submit_amount").val();
        description = $("#reimb_submit_description").val();
        type = $("#reimb_submit_type").val();

        console.log(amount + " " + description + " " + type);

        var typeObj = {type: type};
        var reimbursementObj = JSON.stringify({amount: amount, description: description, type: typeObj});

        $.ajax({
            method: "POST",
            url: ("addReimbursement.do"),
            data: reimbursementObj,
            success: function (data) {
                reimb = data;
                $("#reimb_table").find("tbody").prepend("" +
                    "<tr disabled> " +
                    "<td class='reimb_status'>" + reimb.status.status + "</td> " +
                    "<td class='reimb_type'>" + reimb.type.type + "</td> " +
                    "<td class='reimb_amount'>$" + reimb.amount + "</td> " +
                    "<td class='reimb_description'>" + reimb.description + "</td> " +
                    "<td class='reimb_submit_time'>" + new moment().format("MM/DD/YY hh:mm A") + "</td> " +
                    "<td class='reimb_resolved_time'></td> " +
                    "</tr>");
            }
        });
    } //addReimbursement

    /**
     * Checks if all fields are filled out,
     * upon click of reimbursement submit,
     *  if not, prompts user to fill out
     *  else, submits the form
     */
    $("#reimbursement_submit").click(function () {
        console.log("submit button clicked");
        //check if all the fields are filled out
        amount = $.trim($("#reimb_submit_amount").val());
        description = $.trim($("#reimb_submit_description").val());
        type = $.trim($("#reimb_submit_type").val());

        if(!amount || !description || !type) {
            $("#reimbursement_submit").popover("show");
            console.log("Please make sure all fields are filled out");
        } else { //if input is not empty
            //closes the modal
            $('#reimbursementModal').modal('toggle');
            //submits the form
            addReimbursement();
            //resets modal data
            $("#reimb_submit_amount").html("");
            $("#reimb_submit_description").html("");
            $("#reimb_submit_type").html("");
        }
    });

    /**
     * Displays popover to fill in all fields
     * upon any keypress within reimbursement modal
     */
    $("#reimbursementModal").keyup(function () {
        amount = $.trim($("#reimb_submit_amount").val());
        description = $.trim($("#reimb_submit_description").val());
        type = $.trim($("#reimb_submit_type").val());

        if(!amount || !description || !type) {
            if(!($('.popover-content').length > 0)) {
                console.log("Popover length: " + $('.popover-content').length);
                $("#reimbursement_submit").popover("show");
            }
        }
        else {
            $("#reimbursement_submit").popover("hide");
        }
    });



    /**
 * Manager View functions
 */

    /**
     * Unlocks the select boxes upon clicking on the edit button
     */
    $(document).on('click','.edit_row a',function() {
        $(this).closest('tr').find('select')
            .prop('disabled', function(_, prop){ return !prop});
    });


    /**
     * Upon change of select box for Reimbursement status or type,
     * sends AJAX post request to change to alter database data
     *
     * Updates the resolved time and resolver full name field in table upon completion
     */
    $('.reimb_status').change(function(){

        var that = $(this);

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
                result = data;

                /**
                 * Sets resolver fields in the table
                 *  if status is pending, remove resolver fields
                 */
                if(result.status.status === "Pending") {
                    console.log("Status: " + result.status.status);
                    that.closest('tr').find('.reimb_resolved_time').empty();
                    that.closest('tr').find('.reimb_resolver_full_name').empty();
                } else { //empty the resolver fields if status is pending
                    //set resolved time
                    var now = new moment();
                    that.closest('tr').find('.reimb_resolved_time').html(now.format("MM/DD/YY hh:mm A"));
                    //set resolver full name
                    that.closest('tr').find('.reimb_resolver_full_name')
                        .html(result.resolver.firstName + " " + result.resolver.lastName);
                }

            }
        });
    });

    /**
     * Sends AJAX post request to change to alter database data
     * upon change of select box for Reimbursement status or type,
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
