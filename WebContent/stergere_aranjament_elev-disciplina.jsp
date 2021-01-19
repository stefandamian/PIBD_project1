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
    <title>Stergere Aranjament Elev - Disciplina</title>
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
  String idDisciplina = request.getParameter("idDisciplina");

  String[] idElevi = request.getParameterValues("idElevi");
  
  if (idElevi != null){
    jb.connect();
    int id_int_disciplina = Integer.parseInt(idDisciplina);
    for(int i = 0; i< idElevi.length; i++)
      jb.stergeAranjament(id_int_disciplina, Integer.parseInt(idElevi[i]));
    jb.disconnect();
  %>
  <div class="container-fluid col-md-12">
    <div class="page-header">
      <h1>Stergere reusita</h1>
    </div>
    <div class="col-md-6">
      <a class="btn btn-primary" href="vizualizare_disciplina.jsp?id=<%=idDisciplina%>" style="margin-top: 8px;">Inapoi la disciplina</a>
    </div>
  </div>
  <% }
  else{
    jb.connect();
    ResultSet rs = jb.intoarceLinieDupaId("discipline", "iddisciplina", Integer.parseInt(idDisciplina));
    if(rs != null)
      rs.next();
    ResultSet rsProfesor = jb.intoarceLinieDupaId("profesori", "idprofesor", rs.getInt("idprofesor"));
    if(rsProfesor != null)
      rsProfesor.next();
%>
<div class="container-fluid col-md-12 row">
  <div class="col-md-6">
  <div class="page-header">
    <h1>Sterge aranjament disciplina-elev</h1>
  </div>
  <h3>Disciplina: <%=rs.getString("nume")%></h3>
  <h3>Profesor: <%=rsProfesor.getString("nume")%> <%=rsProfesor.getString("prenume")%></h3>
  </div>
  <%
  rs.close();
  rsProfesor.close();
  
  rs = jb.getEleviForIdDisciplina(Integer.parseInt(idDisciplina));
  boolean hasResults = rs.isBeforeFirst();
  if (hasResults){
  %>
  <div class="col-md-2">
  <form class="form-group" action="stergere_aranjament_elev-disciplina.jsp" method="post">
     <select multiple class="selectpicker" NAME="idElevi">
     <%
       while(rs.next()){
    %>
         <option value="<%=rs.getInt("idelev")%>"><%=rs.getString("numeElev")%> <%=rs.getString("prenumeElev")%>, an <%=rs.getInt("anElev")%></option>
    <%
    }
     rs.close();
    %>
     </select>
     
     <input type="hidden" name="idDisciplina" value="<%=idDisciplina%>">
     <div style="margin-top: 8px;"><input class="btn btn-primary" type="submit" value="Stergere Elev" /></div>
  </form>
  </div>
  <%} else { %>
  <div class="col-md-4" style="margin-top: 8px;">
      <h4> Disciplina nu are nici un elev inrolat</h4>
      <a class="btn btn-primary" href="vizualizare_disciplina.jsp?id=<%=idDisciplina%>" style="margin-top: 8px;">Inapoi la disciplina</a>
  </div>
<% 
  }
  jb.disconnect();
  rs.close();
  } 
  %>
</div> 
</body>