<%@page import="com.secrbac.pojo.User"%>
<%
	User user = (User) session.getAttribute("user");
	if (user == null) {
		response.sendRedirect("login.jsp?msg=Please login to continue");
	} else {
%>


<html lang="en">
<head>
<title>SecRBAC</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/font-awesome.min.css" rel="stylesheet">
<link href="css/prettyPhoto.css" rel="stylesheet">
<link href="css/animate.css" rel="stylesheet">
<link href="css/main.css" rel="stylesheet">
<!--[if lt IE 9]>
  <script src="js/html5shiv.js"></script>
  <script src="js/respond.min.js"></script>
  <![endif]-->
<link rel="shortcut icon" href="images/ico/favicon.ico">
<link rel="apple-touch-icon-precomposed" sizes="144x144"
	href="images/ico/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114"
	href="images/ico/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72"
	href="images/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed"
	href="images/ico/apple-touch-icon-57-precomposed.png">
</head>
<!--/head-->
<body>


	<header class="navbar navbar-inverse navbar-fixed-top wet-asphalt"
		role="banner">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="welcome.jsp">SecRBAC</a>
			</div>
			<div class="collapse navbar-collapse">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="welcome.jsp">Welcome</a></li>
					<li><a href="auth_rules.jsp">Auth Rules</a></li>
					<li><a href="write_data.jsp">Write Data</a></li>
					<li><a href="data?type=getmydata">Manage My Data</a></li>
					<li><a href="privilegeData?type=get">My Privileged Data</a></li>
					<li class="dropdown active"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown"><%=user.getFname() %> <%=user.getLname() %> <i class="icon-angle-down"></i></a>
						<ul class="dropdown-menu">
							<li><a href="updateprofile.jsp">Edit Profile</a></li>
							<li><a href="changepassword.jsp">Change Password</a></li>
							<li><a href="account?request_type=deleteprofile">Delete Account</a></li>
							<li><a href="account?request_type=logout">Logout</a></li>
						</ul></li>
				</ul>
			</div>

		</div>
	</header>
	<!--/header-->

	<section id="title" class="emerald">
		<div class="container">
			<div class="row">
				<div class="col-sm-6">
					<h1>Change Password</h1>
					<p>You can change your password here.</p>
				</div>

			</div>
		</div>
	</section>
	<!--/#title-->

	<section id="career" class="container">
		<!-- 		<div class="center"> -->
		<!-- 			<h2>LOGIN</h2> -->
		<!-- 			<p>Please provide your credentials.</p> -->
		<!-- 		</div> -->
		<!-- 		<hr> -->

		<div class="row">
			<%
				String msg = request.getParameter("msg");
					if (msg != null && msg.trim().length() > 0) {
			%>
			<br />
			<h4><%=msg%></h4>
			<br /> <br />
			<%
				}
			%>
			
			
			
			<form action='account' method=post class='col-md-6'>
				<input type=hidden name='request_type' value='changepassword' />
				<label>Email ID</label>
				<input type=text class='form-control' name='email' value='<%=user.getEmail()%>' readonly="readonly" />
				<br/>
				
				<label>Current Password</label>
				<input type=password class='form-control' name='oldpassword' value='Current Password'  />
				<br/>
				
				<label>New Password</label>
				<input type=password class='form-control' name='newpassword' value='New password'  />
				<br/>
				
				<input type=submit class='btn btn-success' value='Update Profile' />
			</form>


		</div>
	</section>


	<br />
	<br />
	<br />
	<br />

	<footer id="footer" class="midnight-blue">
		<div class="container">
			<div class="row">
				<div class="col-sm-6">&copy; 2017 SecRBAC. All Rights Reserved.</div>

			</div>
		</div>
	</footer>

	<!--/#footer-->

	<script src="js/jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.prettyPhoto.js"></script>
	<script src="js/main.js"></script>
</body>
</html>

<%
	}
%>