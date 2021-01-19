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
    <title>Stergere aranjament</title>
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
<%
  if (request.getParameter("submit") != null){
    int nr_stergeri = 0;
    String[] iduri = request.getParameterValues("iddisciplina&idelev");
    if (iduri != null){
      jb.connect();
      for(int j = 0; j < iduri.length; j++){
        System.out.println(iduri[j]);
        String[] ids = iduri[j].split("&");
        int idDisciplina = Integer.parseInt(ids[0]);
        int idElev = Integer.parseInt(ids[1]);
        jb.stergeAranjament(idDisciplina, idElev);
        nr_stergeri = nr_stergeri + 1; 
      }
      jb.disconnect(); 
    }
    %>
    <div class="container-fluid col-md-12">
      <div class="page-header">
      <%if (nr_stergeri >1){ %>
        <h1>Stergere reusita(<%=nr_stergeri%> aranjamente sterse).</h1>
      <% } else { %>
        <h1>Stergere reusita.</h1>
      <% } %>
      </div>
      <div class="col-md-6">
        <a class="btn btn-primary" href="lista_aranjamente.jsp" style="margin-top: 8px;">Inapoi la aranjamente</a>
      </div>
    </div>
    <%
  }
  else{
     jb.connect();
%>

<div class="container-fluid col-md-12 row">
  <div class="col-md-6">
	  <div class="page-header" style="margin-top: 8px;">
	    <h1>Sterge aranjamente</h1>
	  </div>
    <div class="col-md-3">
		  <form class="form-group" action="stergere_aranjamente.jsp" method="post" style="margin-top: 8px;">
		     <SELECT multiple class="selectpicker" NAME="iddisciplina&idelev" style="margin-top: 8px;">
		     <%
		       ResultSet rs = jb.vedeTabela("aranjamente");
		       while(rs.next()){
		         int iddisciplina = rs.getInt("iddisciplina");
		         int idelev = rs.getInt("idelev");
		         ResultSet rsDisciplina = jb.intoarceLinieDupaId("discipline", "iddisciplina", iddisciplina);
		         rsDisciplina.next();
		         ResultSet rsElev = jb.intoarceLinieDupaId("elevi", "idelev", idelev);
             rsElev.next();
		    %>
		         <OPTION VALUE="<%=iddisciplina%>&<%=idelev%>"><%=rsDisciplina.getString("nume")%>, elev: <%=rsElev.getString("nume")%> <%=rsElev.getString("prenume")%></OPTION>
		    <% } 
		       rs.close();
        %>
		     </SELECT>
		     <input type="hidden" name="submit" value="true">
		     <input type="hidden" name="add" value="add">
		     <div style="margin-top: 8px;"><input class="btn btn-primary" type="submit" value="Sterge Discipline" /></div>
		  </form>
	  </div>
  </div>
  <%
  }
  jb.disconnect();
 %>
</div> 
</body>