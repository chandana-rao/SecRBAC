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
				Data data = (Data) request.getAttribute("data");
				if (data!=null) {
					%>
			<a href='data?type=getmydata' > <span class='glyphicon glyphicon-chevron-left'></span> Go Back</a>
			<br/><br/>
						<br/><br/>
						<form action='data' method=post>
						<input type=hidden name='type' value='update' />
						<table class='table'>
							<tr>
								<th>
									<label>Data ID</label>
								</th>
								<td> <input type="text" name='data_id' readonly="readonly" value='<%=data.getData_id()%>'  class='form-control'/></td>
							</tr>
							<tr>
								<th>
									<label>Description</label>
								</th>
								<td> <input type="text" name='desc' value='<%=data.getDesc()%>'  class='form-control'/></td>
							</tr>
							<tr>
								<th>
									<label>Details</label>
								</th>
								<td> 
									<table class='table'>
									<%
										Map<String, String> keyvalue_map =  data.getKeyvalue();
										Iterator<String> it =  keyvalue_map.keySet().iterator();
										while (it.hasNext()) {
											String k = it.next();
											String v = keyvalue_map.get(k);
											%>
										<tr>
											<td>
												<label>Key</label>
												<input type=text name='key' value='<%=k %>' class='form-control'/>
											</td>
											<td> 
												<label>Value</label>
												<input type=text name='value'  value='<%=v %>' class='form-control' />
											</td>
										</tr>
											<%
										}
									%>
									</table>
								
								</td>
							</tr>
							
							
						</table>
						<input type=submit value='Update Data' class='btn btn-success'/>
						</form>
					<%
				}
			%>
	
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