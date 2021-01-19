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

    <title>Vizualizare elev</title>

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
    <div class="container-fluid col-md-12">
		<div class="page_header">
			<h1>
				Vizualizare elev
			</h1>
		</div>
		<%
	    String idelev = request.getParameter("id");
	    int value = 0;
	    if(idelev != null){
	      value = Integer.parseInt(idelev);
	    }
	    jb.connect();
			if(value > 0){
			  ResultSet rs = jb.intoarceLinieDupaId("elevi", "idelev", value);
			    if (rs.next()){
		%>
		<div class="row" style="margin-top: 30px;">
			<div class = "col-md-5 float_left">
				<h3>Nume: <%= rs.getString("nume")%></h3>
				<h3>Prenume: <%= rs.getString("prenume")%></h3>
				<h3>An: <%= rs.getInt("an")%></h3>
				<a class="btn btn-primary" href="modificare_elev.jsp?id=<%=value%>">Modificare elev</a>
			</div>
			<div class = "col-md-7 float_right">
				<table class="table table-bordered table-sm">
					<thead>
						<tr>
							<th>
								#
							</th>
							<th>
								Disciplina
							</th>
							<th>
								Profesor
							</th>
						</tr>
					</thead>
					<tbody>
						<%
					  rs.close();
						rs = jb.getDisciplineForIdElev(value);
						long x;
	          long i = 0;
	          while (rs.next()) {
	              x = rs.getInt("iddisciplina");
	              if((i % 2) == 0){
	          %>  
						<tr class="table-active">
						<% } else { %>
						<tr>
						<% }
						  i = i + 1; %>
						  <td><%=i%></td>
						  <td><%=rs.getString("numeDisciplina")%></td>
						  <td><%=rs.getString("numeProfesor")%> <%=rs.getString("prenumeProfesor")%></td>
						  <td>
						    <a href="vizualizare_disciplina.jsp?id=<%=x%>" class="btn btn-primary float_right">Vizualizare Disciplina</a>
						  </td>
						</tr>
						<%
						  } 
						%>
					</tbody>
				</table>
				<a href="adaugare_aranjament_disciplina-elev.jsp?id=<%=value%>" class="btn btn-primary float_right">Adaugare Disciplina</a>
				<a href="stergere_aranjament_disciplina-elev.jsp?id=<%=value%>" class="btn btn-primary float_right">Elimina Disciplina</a>
			</div>
		</div>
		<%
	      rs.close();
        }
			}
			else{
		%>
		<div class="page-header">
			<h1>Elevul nu a putut fi accesat</h1>
		</div>
		<%
				}
			jb.disconnect();
		%>
	</div>

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/scripts.js"></script>
  </body>
</html>