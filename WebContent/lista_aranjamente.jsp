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
  
    <title>Aranjamente</title>

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
        <h1>Aranjamente</h1>
      </div>
      <table class="table table-bordered table-sm">
        <thead>
          <tr>
            <th>#</th>
            <th>Disciplina</th>
            <th>Elev</th>
          </tr>
        </thead>
        <tbody>
        <%
          jb.connect();
          ResultSet rs = jb.vedeTabela("aranjamente");
          long i = 0;
          while (rs.next()) {
            int idElev = rs.getInt("idelev");
            int idDisciplina = rs.getInt("iddisciplina");
            ResultSet rsElev = jb.intoarceLinieDupaId("elevi", "idelev", idElev);
            ResultSet rsDisciplina = jb.intoarceLinieDupaId("discipline", "iddisciplina", idDisciplina);
            if (rsElev != null)
              rsElev.next();
            if (rsDisciplina != null)
              rsDisciplina.next();
            ResultSet rsProfesor = jb.intoarceLinieDupaId("profesori", "idprofesor", rsDisciplina.getInt("idprofesor"));
            if (rsProfesor != null)
              rsProfesor.next();
            if((i % 2) == 0){
        %>  
          <tr class="table-active">
          <%
            }
            else{
          %>
          <tr>
          <%}
            i = i + 1; %>
            <td><%=i%></td>
            <td>
              <a><%=rsDisciplina.getString("nume")%>, prof. <%=rsProfesor.getString("nume")%> <%=rsProfesor.getString("prenume")%></a>
              <a href="vizualizare_disciplina.jsp?id=<%=rsDisciplina.getInt("iddisciplina")%>" class="btn btn-primary float_right">Vizualizare Disciplina</a>
            </td>
            <td>
              <a><%=rsElev.getString("nume")%> <%=rsElev.getString("prenume")%></a>
              <a href="vizualizare_elev.jsp?id=<%=rsElev.getInt("idelev")%>" class="btn btn-primary float_right">Vizualizare Elev</a>
            </td>
            <td><a href="modificare_aranjament.jsp?idElev=<%=idElev%>&idDisciplina=<%=idDisciplina%>" class="btn btn-primary float_right">Modificare Aranjament</a></td>
          </tr>
          <%
            } 
          %>
        </tbody>
      </table>
      <a class="btn btn-primary float_right" href="modificare_aranjament.jsp?value=add">Adauga Aranjament</a>
      <a class="btn btn-primary float_right" href="stergere_aranjamente.jsp">Stergere Aranjamente</a>
      <%
            rs.close();
            jb.disconnect();
      %>
    </div>
  </div>
</div>


</body>
</html>