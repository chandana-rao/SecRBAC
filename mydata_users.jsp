<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.secrbac.pojo.Data"%>
<%@page import="java.util.List"%>
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
					<li class='active'><a href="data?type=getmydata">Manage My Data</a></li>
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
					<h1>My Data</h1>
					<p>You can view, update, and delete any of the data you have stored in the cloud. Also, you can set the authorization rules for any of your data.</p>
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
		      <h2>Manage Data</h2>
		      <p>You can view, update, or delete your data from the cloud. <br/>You can also set the authorization rules for your data.<br/></p>
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
			<br/><br/><br/><br/>
			<%
				String data_id = (String) request.getAttribute("data_id");
				String desc = (String) request.getAttribute("desc");
				Map<String, String> users = (Map<String, String>) request.getAttribute("users");
				List<String> availableusers = (List<String>) request.getAttribute("availableusers");
				Map<String, Integer> rolenames = (Map<String, Integer>) request.getAttribute("rolenames");
			%>
			
		
			<a href='data?type=getmydata' > <span class='glyphicon glyphicon-chevron-left'></span> Go Back</a>
			
			<h4> Mapped Users for Data ID : <%=data_id %> (<%=desc %>)</h4>
			<br/><br/>
			<%
				if (users!=null && users.size()>0) {
			%>
			<table class='table'>
			<tr>
				<th> User email </th>
				<th> Role </th>
				<th> Remove </th>
			</tr>
			<%
				Iterator<String> it = users.keySet().iterator();
				while (it.hasNext()) {
					String email = it.next();
					String role = users.get(email);
					%>
						<tr>
							<td> <%=email %></td>
							<td> <%=role %></td>
							<td> <a href='data?type=mapusers_remove&email=<%=email%>&data_id=<%=data_id%>&desc=<%=desc%>'><span class='glyphicon glyphicon-remove'></span> Remove</a></td>
						</tr>						
					<%
				}
			%>
			</table>
			<% } else { %>
				<h4>You have not mapped any users for this data.</h4>				
			<% } %>
			
			<br/><br/>
			
			<%
				if (availableusers!=null && availableusers.size()>0) {
			%>
			
			<h4> Map a New User</h4>
			<br/>
			<form action="data" method=post class='col-md-6'>
				<input type=hidden name='type' value='mapuser' />
				<input type=hidden name='data_id' value='<%=data_id%>' />
				<input type=hidden name='desc' value='<%=desc%>' />
				<label>Select a User</label>
				<select name='email' class='form-control'>
					<%
						for (String email : availableusers) {
							%>
								<option value='<%=email%>'><%=email%> </option>
							<%
						}
					%>
				</select>
				<br/>
				<label>Associate a Role</label>
				<select name='role' class='form-control'>
					<%
						Iterator<String> it = rolenames.keySet().iterator();
						while (it.hasNext()) {
							String rolename = it.next();
							int access = rolenames.get(rolename);
							%>
								<option value='<%=rolename%>'><%=rolename %>
								<%
									if (access==0) {
										%>
										(No Access)
										<%
									} else if (access==1) {
										%>
										(Read Only Access)
										<%
									} else if (access==2) {
										%>
										(Read and Update Access)
										<%
									} else if (access==4) {
										%>
										(Read, Update, and Delete Access)
										<%
									}
								%>
								</option>
							<%
						}
					%>
				</select> 
				<br/>
				<input type=submit value='Map User' class='btn btn-success' />
			</form>
			<% } else { %>
				<h4> No more available users</h4>
			<% } %>
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
		$(document).ready (function() {
			$('#addBtn').click(function() {
				$('#kv').append("				<table class='table'> 					<tr> 						<td> 							<label>Property </label> 							<input type=text name='key' placeholder='key' class='form-control'/> 						</td> 						<td> 							<label>Value </label> 							<input type=text name='value' placeholder='value' class='form-control'/> 						</td> 					</tr> 				</table> ");
			});		
		});
	</script>
</body>
</html>

<%
	}
%>