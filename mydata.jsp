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
				List<Data> data = (List<Data>) request.getAttribute("data");
				if (data==null || data.size()==0) {
					%>
						<h4> You don't have any Data written in the cloud at this moment.</h4>
					<%
				}
				int i=0;
				for (Data dt: data) {
					i++;
					%>
						<div>
							<table class='table'>
								<tr style='background-color:lightgray;'> 
									<td> <a href='data?type=authrule_get&data_id=<%=dt.getData_id()%>&desc=<%=dt.getDesc() %>'  ><span class='glyphicon glyphicon-cog'></span> Auth Rules</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									 <span><a href='data?type=mapusers_get&data_id=<%=dt.getData_id()%>&desc=<%=dt.getDesc()%>'  ><span class='glyphicon glyphicon-user'></span> Map Users</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
									</td>
									
									<td>
										<a href='data?type=delete&data_id=<%=dt.getData_id()%>' style='float:right;' ><span class='glyphicon glyphicon-trash'></span> Delete</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<span style='float:right;'><a href='data?type=update_get&data_id=<%=dt.getData_id()%>'><span class='glyphicon glyphicon-edit'></span> Update</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>

									</td>
									
								</tr>
								<tr>
									<th>Data ID</th>
									<td><%=dt.getData_id() %></td>
								</tr>
								<tr>
									<th>Description</th>
									<td><%=dt.getDesc() %></td>
								</tr>
								<tr>
									<th></th>
									<td> 
										
										        <div class="panel-group" id="accordion2">
														<div class="panel panel-default">
											            <div class="panel-heading">
											              <h4 class="panel-title">
											                <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseOne<%=i%>">
											                  View Details
											                </a>
											              </h4>
											            </div>
											            <div id="collapseOne<%=i%>" class="panel-collapse collapse">
											              <div class="panel-body">
											                <table class='table'>
																<tr>
																	<th> Property </th>
																	<th> Value </th>
																</tr>
																
																<%
																	Iterator<String> it =  dt.getKeyvalue().keySet().iterator();
																	while (it.hasNext()) {
																		String key = it.next();
																		String value = dt.getKeyvalue().get(key);
																		%>
																			<tr>
																				<td><%=key %></td>
																				<td><%=value %></td>
																			</tr>
																		<%
																	}
																%>
											
															</table>
											              </div>
											            </div>
											          </div>												
												</div>
										
										
									
									</td>
								</tr>
							</table>						
						</div>
					
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