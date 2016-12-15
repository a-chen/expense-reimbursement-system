<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="header.jsp" >
    <jsp:param name="pageTitle" value="ERS: Main" />
</jsp:include>

<body>
    <jsp:include page="navbar.jsp" />

    <button id="reimb_table_submit">Save Changes and Reload</button>
    <table id="example" class="display nowrap dataTable dtr-inline collapsed" cellspacing="0" width="100%" role="grid" aria-describedby="example_info" style="width: 100%;">
        <thead>
        <tr role="row">
            <th></th>
            <th>Status</th>
            <th>Type</th>
            <th>Reimb ID</th>
            <th>Name</th>
            <th>Amount</th>
            <th>Date Submitted</th>
            <th>Date Resolved</th>
            <th>Resolver</th>
            <th>Description</th>
            <th>Email</th>
        </tr>
        </thead>
        <tfoot>
        <tr>
            <th></th>
            <th>Status</th>
            <th>Type</th>
            <th>Reimb ID</th>
            <th>Name</th>
            <th>Amount</th>
            <th>Date Submitted</th>
            <th>Date Resolved</th>
            <th>Resolver</th>
            <th>Description</th>
            <th>Email</th>
        </tr>
        </tfoot>
        <tbody>
        <c:forEach var="reimb" items="${reimbursements}">
            <tr disabled>
                <%--Edit onclick unlocks reimb_status and reimb_type--%>
                <td class="edit_row"><a href="#" class="btn btn-info btn-lg">
                    <span class="glyphicon glyphicon-pencil"></span>
                </a></td>
                <td class="reimb_status">
                    <select name="reimb_status" disabled>
                        <c:forEach var="status" items="${statuses}">
                            <c:choose>
                                <%-- automatically load from database --%>
                                <c:when test="${reimb.status.status == status.status}">
                                    <option selected>${reimb.status.status}
                                </c:when>

                                <c:otherwise>
                                    <option>${status.status}
                                </c:otherwise>
                            </c:choose>

                            </option>
                        </c:forEach>
                    </select>
                </td>
                <td class="reimb_type">
                    <select name="reimb_type" disabled>
                        <c:forEach var="type" items="${types}">
                            <c:choose>
                                <c:when test="${reimb.type.type == type.type}">
                                    <option selected>${reimb.type.type}
                                </c:when>

                                <c:otherwise>
                                    <option>${type.type}
                                </c:otherwise>
                            </c:choose>

                            </option>
                        </c:forEach>
                    </select>
                </td>
                <td class="reimb_id"><c:out value="${reimb.id}" /></td>
                <td class="reimb_author_name"><c:out value="${reimb.author.lastName}, ${reimb.author.firstName}" /></td>
                <td class="reimb_amount"><fmt:formatNumber value="${reimb.amount}" type="currency"/></td>
                <td class="reimb_submit_time"><fmt:formatDate pattern="MM/dd/yyyy hh:mm a" value="${reimb.submitted}"/></td>
                <td class="reimb_resolved_time"><fmt:formatDate pattern="MM/dd/yyyy hh:mm a" value="${reimb.resolved}"/></td>
                <td class="reimb_resolver_full_name"><c:out value="${reimb.resolver.firstName} ${reimb.resolver.lastName}" /></td>
                <td class="reimb_description"><c:out value="${reimb.description}" /></td>
                <td class="reimb_author_email"><c:out value="${reimb.author.email}" /></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

</body>
</html>