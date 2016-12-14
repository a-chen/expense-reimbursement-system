<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="header.jsp" >
    <jsp:param name="pageTitle" value="ERS: Main" />
</jsp:include>

<body>
<jsp:include page="navbar.jsp" />

<div class="container">
    <button id="reimb_table_submit">Save Changes and Reload</button>
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
            <tr disabled>
                    <%--Edit onclick unlocks reimb_status and reimb_type--%>
                <td class="edit_row"><a>Edit</a></td>
                <td class="reimb_id"><c:out value="${reimb.id}" /></td>
                <td class="reimb_author_last_name"><c:out value="${reimb.author.lastName}" /></td>
                <td class="reimb_author_first_name"><c:out value="${reimb.author.firstName}" /></td>
                <td class="reimb_amount"><fmt:formatNumber value="${reimb.amount}" type="currency"/></td>
                <td class="reimb_submit_time"><c:out value="${reimb.submitted}" /></td>
                <td class="reimb_resolved_time"><c:out value="${reimb.resolved}" /></td>
                <td class="reimb_resolver_full_name"><c:out value="${reimb.resolver.firstName} ${reimb.resolver.lastName}" /></td>
                <td class="reimb_description"><c:out value="${reimb.description}" /></td>
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
                <td class="reimb_author_email"><c:out value="${reimb.author.email}" /></td>
            </tr>
        </c:forEach>
    </table>
</div>

    <%--<table id="example" class="display nowrap dataTable dtr-inline collapsed" cellspacing="0" width="100%" role="grid" aria-describedby="example_info" style="width: 100%;">
        <thead>
        <tr role="row">
            <th class="sorting_asc" tabindex="0" aria-controls="example" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" style="width: 136px;">Name</th>
            <th class="sorting" tabindex="0" aria-controls="example" rowspan="1" colspan="1" aria-label="Position: activate to sort column ascending" style="width: 185px;">Position</th>
            <th class="sorting" tabindex="0" aria-controls="example" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending" style="width: 85px;">Office</th>
            <th class="dt-body-right sorting" tabindex="0" aria-controls="example" rowspan="1" colspan="1" aria-label="Age: activate to sort column ascending" style="width: 34px;">Age</th>
        </tr>
        </thead>
        <tfoot>
        <tr>
            <th rowspan="1" colspan="1">Name</th>
            <th rowspan="1" colspan="1">Position</th>
            <th rowspan="1" colspan="1">Office</th>
            <th class="dt-body-right" rowspan="1" colspan="1">Age</th>
        </tr>
        </tfoot>
        <tbody>
        <tr role="row" class="odd">
            <td class="sorting_1">Airi Satou</td>
            <td>Accountant</td>
            <td>Tokyo</td>
            <td class=" dt-body-right">33</td>
        </tr>
        <tr role="row" class="even">
            <td class="sorting_1">Angelica Ramos</td>
            <td>Chief Executive Officer (CEO)</td>
            <td>London</td>
            <td class=" dt-body-right">47</td>
        </tr>
        </tbody>
    </table>--%>

</body>
</html>