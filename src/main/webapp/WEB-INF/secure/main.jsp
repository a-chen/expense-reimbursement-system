<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="header.jsp" >
    <jsp:param name="pageTitle" value="ERS: Main" />
</jsp:include>

    <body>
        <jsp:include page="navbar.jsp" />

        <%--Loads different views for each role--%>
        <c:choose>
            <c:when test="${user.role.role == 'HR'
                         || user.role.role == 'Admin'}">
                <jsp:include page="managerView.jsp" />
            </c:when>
            <c:otherwise>
                <jsp:include page="employeeView.jsp" />
            </c:otherwise>
        </c:choose>

    </body>
</html>