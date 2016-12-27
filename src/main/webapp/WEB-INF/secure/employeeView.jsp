<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- to be included in main.jsp --%>

<!-- add reimbursement modal -->
<!-- Button trigger modal -->
<button id="launch_reimbursement_modal" type="button" class="btn btn-primary btn-md" data-toggle="modal" data-target="#reimbursementModal">
    <span class="glyphicon glyphicon-plus"></span>
</button>

<!-- Modal -->
<div class="modal fade" id="reimbursementModal" tabindex="-1" role="dialog" aria-labelledby="reimbursementModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">x</span>
                </button>
                <h4 class="modal-title" id="reimbursementModalLabel">New Reimbursement</h4>
            </div>
            <div class="modal-body">

                <h5>Description</h5>
                <textarea id="reimb_submit_description" class="form-control"  maxLength="250" rows="4" autofocus required></textarea>

                <h5>Amount</h5>
                <div class="input-group">
                    <span class="input-group-addon">$</span>
                    <input type="number" step=0.01 id="reimb_submit_amount" class="form-control" placeholder="0.00" required>
                </div>

                <h5>Category</h5>
                <select id="reimb_submit_type" class="selectpicker" title="Please choose one" required>
                    <c:forEach var="type" items="${types}">
                        <option>${type.type}</option>
                    </c:forEach>
                </select>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button id="reimbursement_submit" type="button" class="btn btn-primary" data-trigger="focus"
                        data-toggle="popover" data-placement="top" data-content="Please fill out all fields">Save changes</button>
            </div>

        </div>
    </div>
</div> <!-- /reimbursement modal -->

<!-- reimbursement table -->
<table id="reimb_table" class="display nowrap dataTable dtr-inline collapsed" cellspacing="0" width="100%" role="grid" aria-describedby="example_info" style="width: 100%;">
    <thead>
    <tr role="row">
        <th>Status</th>
        <th>Type</th>
        <th>Amount</th>
        <th>Description</th>
        <th>Date Submitted</th>
        <th>Date Resolved</th>
    </tr>
    </thead>
    <tfoot>
    <tr>
        <th>Status</th>
        <th>Type</th>
        <th>Amount</th>
        <th>Description</th>
        <th>Date Submitted</th>
        <th>Date Resolved</th>
    </tr>
    </tfoot>
    <tbody>

    <c:forEach var="reimb" items="${reimbursements}">
        <tr disabled>
            <td class="reimb_status"><c:out value="${reimb.status.status}"/></td>
            <td class="reimb_type"><c:out value="${reimb.type.type}"/></td>
            <td class="reimb_amount"><fmt:formatNumber value="${reimb.amount}" type="currency"/></td>
            <td class="reimb_description"><c:out value="${reimb.description}" /></td>
            <td class="reimb_submit_time"><fmt:formatDate pattern="MM/dd/yy hh:mm a" value="${reimb.submitted}"/></td>
            <td class="reimb_resolved_time"><fmt:formatDate pattern="MM/dd/yy hh:mm a" value="${reimb.resolved}"/></td>
        </tr>
    </c:forEach>
    </tbody>
</table>