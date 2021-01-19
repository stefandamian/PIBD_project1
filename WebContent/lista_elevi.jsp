<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java"
	import="db.*, java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	
    <title>Elevi</title>

    <meta name="description" content="Source code generated using layoutit.com">
    <meta name="author" content="LayoutIt!">

    <link href="bootstrap.css" rel="stylesheet">
    <link href="style.css" rel="stylesheet">

</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark" style="margin-bottom: 15px;">
  <ul class="navbar-nav">
    <li class="nav-item" style="margin: 4px;">
      <a class="nav-link" href="index.html">Home</a>
    </li>
    <li class="nav-item" style="margin: 4px;">
      <a class="nav-link" href="lista_elevi.jsp">Elevi</a>
    </li>
    <li class="nav-item" style="margin: 4px;">
      <a class="nav-link" href="lista_discipline.jsp">Discipline</a>
    </li>
    <li class="nav-item" style="margin: 4px;">
      <a class="nav-link" href="lista_profesori.jsp">Profesori</a>
    </li>
    <li class="nav-item" style="margin: 4px;">
      <a class="nav-link" href="lista_aranjamente.jsp">Aranjamente</a>
    </li>
  </ul>
</nav>
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<div class="page-header margin-25">
				<h1>Elevi</h1>
			</div>
			<table class="table table-bordered table-sm">
				<thead>
					<tr>
						<th>#</th>
						<th>Nume</th>
						<th>Prenume</th>
						<th>An</th>
					</tr>
				</thead>
				<tbody>
				<%
          jb.connect();
          ResultSet rs = jb.vedeTabela("elevi");
          long x;
          long i = 0;
          while (rs.next()) {
            x = rs.getInt("idelev");
        	  if((i % 2) == 0){
        %>	
					<tr class="table-active">
					<%
                		}
                		else{
					%>
					<tr>
					<%	}
						i = i + 1; %>
						<td><%=i%></td>
						<td><%=rs.getString("nume")%></td>
						<td><%=rs.getString("prenume")%></td>
						<td><%=rs.getInt("an")%></td>
						<td><a href="vizualizare_elev.jsp?id=<%=x%>" class="btn btn-primary float_right">Vizualizare</a></td>
					</tr>
					<%
						} 
					%>
				</tbody>
			</table>
			<a class="btn btn-primary float_right" href="modificare_elev.jsp?value=add">Adauga Elev</a>
			<%
            	rs.close();
            	jb.disconnect();
        	%>
		</div>
	</div>
</div>


</body>
</html>