<nav class="navbar navbar-default">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">ERS</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">Reimbursements</a></li>
                <li><a href="#">Account</a></li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="#">
                        <form action="logout.do" method="post">
                            <input type="submit" value="Logout" />
                        </form>
                    </a>
                </li>
                <%--<li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">Action</a></li>
                        <li><a href="#">Another action</a></li>
                        <li>
                            <a href="#">
                                <form action="logout.do" method="post">
                                    <input type="submit" value="Logout" />
                                </form>
                            </a>
                        </li>
                    </ul>
                </li>--%>
            </ul>
        </div><!--/.nav-collapse -->
    </div><!--/.container-fluid -->
</nav>