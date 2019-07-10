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
					<li class='active'><a href="auth_rules.jsp">Auth Rules</a></li>
					<li><a href="write_data.jsp">Write Data</a></li>
					<li><a href="data?type=getmydata">Manage My Data</a></li>
					<li><a href="privilegeData?type=get">My Privileged Data</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
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
					<h1>Authorization Rules</h1>
					<p>Here you can define a new set of Authorization rules and also view the existing rules or even delete them.</p>
				</div>

        <div class="col-sm-6">
          <ul class="breadcrumb pull-right">
            <li><a href="auth_rules.jsp">Define a new Rule</a></li>
            <li><a href="auth?type=get">View Rules</a></li>
          </ul>
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
		
			<div class="center">
		      <h2>Define a new Authorization Rule</h2>
		      <p>Please provide the role name and the access rights for this authorization rule. <br/>You can add as many roles as you need.<br/></p>
		    </div>
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

			<form action="auth" class='col-md-6'>
			<input type=hidden name='type' value='add_rule' />
			<input  type=button class='btn btn-default' value='Add another Role' id='roleBtn'/>
						<br/> 
			<br/> 
			
			<div id='role'>
				<label>
					Role Name
				</label>	
				<input class='form-control' type=text name='rolename' placeholder='Enter the role name' />
				<br/>
				<label>
					Access
				</label>	<br/>
				<select name='access' class='form-control'>
					<option value='-'>No Access</option>
					<option value='R'>Read Only</option>
					<option value='RU'>Read and Update</option>
					<option value='RUD'>Read, Update, and Delete</option>
				</select>
				<hr/><br/><br/>
			</div>
			
			<input type=submit class='btn btn-success' value='Submit Rule Definition' />
			</form>
			


		</div>
	</section>


	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
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
	
	<script>
	
	$(document).ready(function() {
		$('#roleBtn').click(function() {
			$('#role').append("				<label> 					Role Name 				</label>	 				<input class='form-control' type=text name='rolename' placeholder='Enter the role name' /> 				<br/> 				<label> 					Access 				</label>	<br/> 				<select name='access' class='form-control'> 					<option value='-'>No Access</option> 					<option value='R'>Read Only</option> 					<option value='RU'>Read and Update</option> 					<option value='RUD'>Read, Update, and Delete</option> 				</select> 				<hr/><br/><br/>");
		});
	});
	
	</script>
	
</body>
</html>

<%
	}
%>