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
    <title>Stergere Disciplina - Elev</title>
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
  String idelev = request.getParameter("id");
  int value = 0;
  if(idelev != null){
    value = Integer.parseInt(idelev);
  }
  String[] iddiscipline = request.getParameterValues("iddisciplina");
  if (iddiscipline != null){
    jb.connect();
    for(int j = 0; j< iddiscipline.length; j++)
      jb.stergeAranjament(Integer.parseInt(iddiscipline[j]), value);
    jb.disconnect();
  %>
  <div class="container-fluid col-md-12">
    <div class="page-header">
      <h1>Stergere reusita</h1>
    </div>
    <div class="col-md-6">
      <a class="btn btn-primary" href="vizualizare_elev.jsp?id=<%=idelev%>" style="margin-top: 8px;">Inapoi la elev</a>
    </div>
  </div>
  <% }
  else{
     String err = null;
     String id = null;
     int idElev = -1;
     id = request.getParameter("id");
     if (id == null)
      err = "id404";
     else
       idElev = Integer.parseInt(id);
     
     if(err == null){
     jb.connect();
     ResultSet rs = jb.intoarceLinieDupaId("elevi", "idelev", idElev);
     if (rs.next()){
%>

<div class="container-fluid col-md-12 row">
  <div class="col-md-6">
  <div class="page-header" style="margin-top: 8px;">
    <h1>Sterge aranjament disciplina-elev</h1>
  </div>
  <h3>Nume: <%= rs.getString("nume")%></h3>
  <h3>Prenume: <%= rs.getString("prenume")%></h3>
  <h3>An: <%= rs.getInt("an")%></h3>
  </div>
  <%
  }else{
    err = "resultSetElev404";
  }
  rs.close();
  
  rs = jb.getDisciplineForIdElev(idElev);
  boolean hasResults = rs.isBeforeFirst();
  if (hasResults){
  %>
  <div class="col-md-2">
  <form class="form-group" action="stergere_aranjament_disciplina-elev.jsp" method="post" style="margin-top: 8px;">
     <SELECT multiple class="selectpicker" NAME="iddisciplina" style="margin-top: 8px;">
     <%
       while(rs.next()){
         int iddisciplina = rs.getInt("iddisciplina");
         String numeDisciplina = rs.getString("numeDisciplina");
         String numeProfesor = rs.getString("numeProfesor");
         String prenumeProfesor = rs.getString("prenumeProfesor");
    %>
         <OPTION VALUE="<%= iddisciplina%>"><%= numeDisciplina%>, prof: <%= numeProfesor%> <%= prenumeProfesor%></OPTION>
    <% } %>
     </SELECT>
     <input type="hidden" name="id" value="<%=idElev%>">
     <input type="hidden" name="add" value="add">
     <div style="margin-top: 8px;"><input class="btn btn-primary" type="submit" value="Sterge Discipline" /></div>
  </form>
  </div>
  <%} else { %>
  <div class="col-md-4" style="margin-top: 8px;">
      <h4> Elevul nu este inrolat la nici o disciplina</h4>
      <a class="btn btn-primary" href="vizualizare_elev.jsp?id=<%=idelev%>" style="margin-top: 8px;">Inapoi la elev</a>
  </div>
<% 
  }
  jb.disconnect();
  rs.close();
  } else { %>
  <div><h1>S-a produs o eroare (cod: <%=err%>)</h1></div>
  <%}} %>
</div> 
</body>