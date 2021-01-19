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
  <title>Adaugare Disciplina-Profesor</title>

  <meta name="description" content="Source code generated using layoutit.com">
  <meta name="author" content="LayoutIt!">

  <link href="bootstrap.css" rel="stylesheet">
  <link href="style.css" rel="stylesheet">
  
  <%
  String idProfesor = request.getParameter("idProfesor");
  boolean submit = false;
  if (request.getParameter("submit") != null)
    submit = true;
  
  %>

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
<div class="container-fluid row">
  <%
    if (!submit){
  %>
    <div class = "page-header">
      <h3>Adaugare disciplina pentru profesor</h3>
    </div>
    <%
      jb.connect();
      ResultSet rsProf = jb.intoarceLinieDupaId("profesori", "idprofesor", Integer.parseInt(idProfesor));
      rsProf.next();
    %>
    <div class="col-md-4">
      <h5>Nume: <%=rsProf.getString("nume")%></h5>
      <h5>Prenume: <%=rsProf.getString("prenume")%></h5>
    </div>
    <div class="col-md-4">
      <form role="form" method="post" action="adaugare_disciplina-profesor.jsp">
        <div class="form-group" style="margin-top: 8px;">
          <label for="numeDisciplina">
            Nume
          </label>
          <input type="text" class="form-control" name="numeDisciplina" placeholder="Nume Disciplina" value="">
        </div>
        <input type="hidden" name="submit" value="true">
        <input type="hidden" name="idProfesor" value="<%=idProfesor%>">
        <button type="submit" class="btn btn-primary" style="margin-top: 8px;">
          Submit
        </button>
      </form>
    </div>
    
    <% } else { 
         jb.connect();
         ResultSet rsDisciplina = jb.adaugaDisciplina(Integer.parseInt(idProfesor), request.getParameter("numeDisciplina"));
    %>
    <div class = "page-header">
      <h3>Disciplina adaugata cu succes.</h3>
    </div>
    <div class="col-md-2">
      <a href="vizualizare_disciplina.jsp?id=<%=rsDisciplina.getInt("iddisciplina")%>" class="btn btn-primary" style="margin-top: 8px;">Vizualizare Disciplina</a>
      <a href="vizualizare_profesor.jsp?id=<%=idProfesor%>" class="btn btn-primary" style="margin-top: 8px;">Inapoi la profesor</a>
    </div>
    <% } %>
    
</div>
<%
  
  jb.disconnect();
%>
</body>
</html>