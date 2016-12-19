<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="header.jsp" >
    <jsp:param name="pageTitle" value="ERS: Main" />
</jsp:include>

    <body>
        <jsp:include page="navbar.jsp" />

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
        <a href="#" title="Header" data-toggle="popover" data-placement="top" data-content="Content">Top</a>
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