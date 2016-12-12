<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="header.jsp" >
    <jsp:param name="pageTitle" value="ERS: Main" />
</jsp:include>

<body>
<jsp:include page="navbar.jsp" />

<div class="container">
    <table class="table">
        <tr>
            <th></th>
            <th>ID</th>
            <th>Last Name</th>
            <th>First Name</th>
            <th>Amount</th>
            <th>Date Submitted</th>
            <th>Date Resolved</th>
            <th>Resolver</th>
            <th>Description</th>
            <th>Status</th>
            <th>Type</th>
            <th>Email</th>
        </tr>
        <%--Prints out all Reimbursements--%>
        <c:forEach var="reimb" items="${reimbursements}">
            <tr>
                    <%--Edit onclick unlocks reimb_status and reimb_type--%>
                <td class="edit_row"><a href="">Edit</a></td>
                <td class="reimb_id"><c:out value="${reimb.id}" /></td>
                <td class="reimb_author_last_name"><c:out value="${reimb.author.lastName}" /></td>
                <td class="reimb_author_first_name"><c:out value="${reimb.author.firstName}" /></td>
                <td class="reimb_amount"><fmt:formatNumber value="${reimb.amount}" type="currency"/></td>
                <td class="reimb_submit_time"><c:out value="${reimb.submitted}" /></td>
                <td class="reimb_resolved_time"><c:out value="${reimb.resolved}" /></td>
                <td class="reimb_resolver_full_name"><c:out value="${reimb.resolver.firstName} ${reimb.resolver.lastName}" /></td>
                <td class="reimb_description"><c:out value="${reimb.description}" /></td>
                <td class="reimb_status">
                    <select name="status">
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
                    <select name="type">
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
                <td class="reimb_author_email"><c:out value="${reimb.author.email}" /></td>
            </tr>
        </c:forEach>
    </table>
</div>

</body>
</html>