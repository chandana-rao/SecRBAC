<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<%@page import="com.secrbac.pojo.AuthBean"%>
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
		      <h2>Authorization Rules Defined by You</h2>
		      <p>Here are the list of all the Authorization Rules defined by you.<br/> You can't edit them, however you can delete them and create them again.</p>
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
				Map<String,List<AuthBean>> auth_rules = (Map<String,List<AuthBean>>) request.getAttribute("auths");
				if (auth_rules==null || auth_rules.size()==0) {
					%>
						<h4>You don't have any Authorization Rules defined</h4>
					<%
				}
				%>
				
        <div class="panel-group" id="accordion2">
				<%
				Iterator<String> it =  auth_rules.keySet().iterator();
				int i=0;
				while (it.hasNext()) {
					i++;
					String rule_id = it.next();
					List<AuthBean> rules = auth_rules.get(rule_id);
					%>
						
						
						
			<div class="panel panel-default">
            <div class="panel-heading">
              <h4 class="panel-title">
                <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion1" href="#collapseOne<%=i%>">
                  <h4>Rule Identifier : <b><%=rule_id%></b> <a style='float:right;' href='auth?type=delete&rule_id=<%=rule_id%>' class='btn btn-danger'><span class='glyphicon glyphicon-trash'></span> Delete this Rule</a> </h4>
                </a>
              </h4>
            </div>
            <div id="collapseOne<%=i%>" class="panel-collapse collapse">
              <div class="panel-body">
               		<table class='table col-md-6' '>
							
							<tr>
								<th> Role Name </th>
								<th> Read Access </th>
								<th> Update Access </th>
								<th> Delete Access </th>
							</tr>
							
							<%
								for (AuthBean auth : rules) {
									%>
							<tr>
								<td> <%=auth.getRole_name() %> </td>
								<td> 
								
									<%if (auth.getRead().equals("Yes") ){%>
										<span class='glyphicon glyphicon-ok'></span>
									<% } else { %>  
										<span class='glyphicon glyphicon-remove'></span>
									<% } %>
									
								</td>
								<td> 
								
									<%if (auth.getUpdate().equals("Yes") ){%>
										<span class='glyphicon glyphicon-ok'></span>
									<% } else { %>  
										<span class='glyphicon glyphicon-remove'></span>
									<% } %>
								
								
								</td>
								<td> 
								
									<%if (auth.getDelete().equals("Yes") ){%>
										<span class='glyphicon glyphicon-ok'></span>
									<% } else { %>  
										<span class='glyphicon glyphicon-remove'></span>
									<% } %>
								
								
								 </td>
							</tr>									<%
								}
							%>
						
						</table>
              </div>
            </div>
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