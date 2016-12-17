<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- to be included in main.jsp --%>
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