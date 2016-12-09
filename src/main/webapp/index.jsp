<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="header.jsp" >
    <jsp:param name="pageTitle" value="ERS: Main" />
</jsp:include>

<body>
    <jsp:include page="navbar.jsp" />

    <table>
        <tr>
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
                <td><c:out value="${reimb.id}" /></td>
                <td><c:out value="${reimb.author.lastName}" /></td>
                <td><c:out value="${reimb.author.firstName}" /></td>
                <td><c:out value="${reimb.amount}" /></td>
                <td><c:out value="${reimb.submitted}" /></td>
                <td><c:out value="${reimb.resolved}" /></td>
                <td><c:out value="${reimb.resolver.firstName}_${reimb.resolver.lastName}" /></td>
                <td><c:out value="${reimb.description}" /></td>
                <td><c:out value="${reimb.status.status}" /></td>
                <td><c:out value="${reimb.type.type}" /></td>
                <td><c:out value="${reimb.author.email}" /></td>
            </tr>
        </c:forEach>
    </table>

</body>
</html>