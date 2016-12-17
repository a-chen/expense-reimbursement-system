<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="header.jsp" >
    <jsp:param name="pageTitle" value="ERS: Main" />
</jsp:include>

    <body>
        <jsp:include page="navbar.jsp" />


        <!-- Button trigger modal -->
        <button type="button" class="btn btn-primary btn-md" data-toggle="modal" data-target="#myModal">
            <span class="glyphicon glyphicon-plus"></span>
        </button>

        <!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">

                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">x</span>
                        </button>
                        <h4 class="modal-title" id="myModalLabel">New Reimbursement</h4>
                    </div>
                    <div class="modal-body">

                        <h4>Amount</h4>
                        <div class="input-group">
                            <span class="input-group-addon">$</span>
                            <input type="number" id="reimb_submit_amount" class="form-control" min="0.01" placeholder="0.00" required>
                        </div>

                        <h4>Description</h4>
                        <textarea id="reimb_submit_description" class="form-control"  maxLength="250" rows="5" required></textarea>

                        <h4>Type</h4>
                        <select id="reimb_submit_type" class="selectpicker" title="Please choose one" required>
                            <c:forEach var="type" items="${types}">
                                <option>${type.type}</option>
                            </c:forEach>
                        </select>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="addReimbursement" type="button" class="btn btn-primary" data-dismiss="modal">Save changes</button>
                    </div>

                </div>
            </div>
        </div>

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