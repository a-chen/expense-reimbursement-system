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

                //set resolved time
                var now = new moment();
                that.closest('tr').find('.reimb_resolved_time').html(now.format("MM/DD/YY hh:mm A"));
                //set resolver full name
                that.closest('tr').find('.reimb_resolver_full_name')
                    .html(result.resolver.firstName + " " + result.resolver.lastName);
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

;(function ($, window) {

    var intervals = {};
    var removeListener = function(selector) {

        if (intervals[selector]) {

            window.clearInterval(intervals[selector]);
            intervals[selector] = null;
        }
    };
    var found = 'waitUntilExists.found';

    /**
     * @function
     * @property {object} jQuery plugin which runs handler function once specified
     *           element is inserted into the DOM
     * @param {function|string} handler
     *            A function to execute at the time when the element is inserted or
     *            string "remove" to remove the listener from the given selector
     * @param {bool} shouldRunHandlerOnce
     *            Optional: if true, handler is unbound after its first invocation
     * @example jQuery(selector).waitUntilExists(function);
     */

    $.fn.waitUntilExists = function(handler, shouldRunHandlerOnce, isChild) {

        var selector = this.selector;
        var $this = $(selector);
        var $elements = $this.not(function() { return $(this).data(found); });

        if (handler === 'remove') {

            // Hijack and remove interval immediately if the code requests
            removeListener(selector);
        }
        else {

            // Run the handler on all found elements and mark as found
            $elements.each(handler).data(found, true);

            if (shouldRunHandlerOnce && $this.length) {

                // Element was found, implying the handler already ran for all
                // matched elements
                removeListener(selector);
            }
            else if (!isChild) {

                // If this is a recurring search or if the target has not yet been
                // found, create an interval to continue searching for the target
                intervals[selector] = window.setInterval(function () {

                    $this.waitUntilExists(handler, shouldRunHandlerOnce, true);
                }, 500);
            }
        }

        return $this;
    };

}(jQuery, window));

