<%@page import="java.security.acl.Owner"%>
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
					<li><a href="data?type=getmydata">Manage My Data</a></li>
					<li class='active'><a href="privilegeData?type=get">My Privileged Data</a></li>
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
					<h1>My Privileged Data</h1>
					<p>Here, you can access the data for which other registered users have granted some privileges to you.</p>
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
		      <h2>Privileged Data</h2>
		      <p>Here you can access the data for which other registered users have granted some privileges to you.<br/>
		      	Different users might have granted you different levels of Authorization
		      </p>
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
				String data_id  = (String) request.getAttribute("data_id");
				String desc  = (String) request.getAttribute("desc");
				Map<String,String> details  = (Map<String,String>) request.getAttribute("details");
				int access = (Integer) request.getAttribute("access");
			%>
			
			<a href='privilegeData?type=get' > <span class='glyphicon glyphicon-chevron-left'></span> Go Back</a>
			<br/><br/>
			<h4>Access for Data ID: <%=data_id %> (<%=desc %>)</h4>
			<br/>
			<div class='row'>
			<div class='col-md-3'>
			<table class='table'>
				<tr>
					<th> Read </th>
					<td> 
					<%
						if (access>=1) {
							%>
								<span class='glyphicon glyphicon-ok'></span>
							<%
						} else {
							%>
							<span class='glyphicon glyphicon-remove'></span>
							<%
						}
					%>
					</td>
				</tr>
				<tr>
					<th> Write </th>
					<td> 
					<%
						if (access>=2) {
							%>
								<span class='glyphicon glyphicon-ok'></span>
							<%
						} else {
							%>
							<span class='glyphicon glyphicon-remove'></span>
							<%
						}
					%>					
					</td>
				</tr>
				<tr>
					<th> Delete </th>
					<td> 
					<%
						if (access>=4) {
							%>
								<span class='glyphicon glyphicon-ok'></span>
							<%
						} else {
							%>
							<span class='glyphicon glyphicon-remove'></span>
							<%
						}
					%>					
					</td>
				</tr>
			</table>
			</div>
			</div>
			<br/><br/>
			
			<%
				if (access>=1) {
					%>
					
				<table class='table'>
					<tr>
						<th>Key</th>
						<th>Value</th>
					</tr>
					<%
						Iterator<String> it = details.keySet().iterator();
						while (it.hasNext()) {
							String key = it.next();
							String val = details.get(key);
							%>
								<tr>
									<td> 
									<textarea readonly="readonly" class='form-control' rows=4><%=key %></textarea>
									</td>
									<td>
									<textarea readonly="readonly" class='form-control' rows=4><%=val %></textarea>									
									</td>
								</tr>
							<%
						}
					%>
				</table>
					
					<br/><br/>
						
			<h4>To provide you access to this data, the cloud application will have to execute <b>Proxy Re-encryption algorithm</b></h4>
			<h4>Please provide your unique identifier (anything of your choice). The cloud app will generate a secret key for you and send it across an email.</b></h4>
			<h4>The cloud app then performs Re-encryption operation on the above data using your public key. You can use your secret key received over an email to decrypt the data.</b></h4>
			<br/><br/>
			<div class='col-md-4'>
				<form method=post action='privilegeData'>
					<input type=hidden name='type' value='access2' />
					<input type=hidden name='data_id' value='<%=data_id%>' />
					<input type=hidden name='desc' value='<%=desc%>' />
					<input type=hidden name='access' value='<%=access%>' />
					<input type=text class='form-control' name='id' placeholder='Your Identifier' />
					<br/>
					<input type=submit id='idBtn' value='Execute Proxy Re-encryption Algorithm' class='btn btn-success' /> 
				</form>	
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
			$('#idBtn').click(function() {
				$('#idBtn').hide();
			});
			
		});
	</script>
</body>
</html>

<%
	}
%>