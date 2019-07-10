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
				<a class="navbar-brand" href="index.html">SecRBAC</a>
			</div>
			<div class="collapse navbar-collapse">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="index.jsp">Home</a></li>
					<li class="dropdown active"><a href="#"
						class="dropdown-toggle" data-toggle="dropdown">User <i
							class="icon-angle-down"></i></a>
						<ul class="dropdown-menu">
							<li><a href="login.jsp">Login</a></li>
							<li><a href="register.jsp">Register</a></li>
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
					<h1>Login</h1>
					<p>You can login to your cloud app account here.</p>
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
			if (msg!=null && msg.trim().length()>0) {
				%>
				<br/>
				<h4><%=msg %></h4><br/><br/>
				<%
			}
		%>
		
		
		<form class='col-md-6' action='account' method="post">
			<input type=hidden name='request_type' value='login' />
			<label>Email ID: </label>
			<br/>
			<input type=text name='email' class='form-control' placeholder='Email ID'/>
			<br/>
				<label>Password: </label>
			<br/>
			<input type=password name='password' class='form-control' placeholder='Password'/>
			<br/>
			<input type=reset class='btn btn-btn-default' value='Clear'/>&nbsp;&nbsp;&nbsp;&nbsp;			
			<input type=submit class='btn btn-success' value='Login'/>
			&nbsp;&nbsp;&nbsp;&nbsp;	
			<a href='forgotpassword.jsp' >Forgot Password?</a>
		</form>
		</div>
	</section>  
	<!-- /Career -->


		<br/><br/><br/><br/><br/><br/><br/><br/><br/>

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