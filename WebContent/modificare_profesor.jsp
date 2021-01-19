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
  <%
    boolean submit = false;
    String title = null;
    String err = null;
    int idProfesor = 0;
    String id = request.getParameter("idProfesor");
    if (id != null){
      submit = true;
    }
    
    if(submit){
      idProfesor = Integer.parseInt(id);
      if (idProfesor > 0){
        title = "Modificare profesor";
      }
      else{
        title = "Adaugare profesor";
      }
    }
    else {
      id = request.getParameter("id");
      String value = request.getParameter("value");
      if(value != null){
        title = "Adaugare profesor";
      }
      else{
        if (id != null){
          try{
            idProfesor = Integer.parseInt(id);
            title = "Modificare profesor";
          }
          catch(NumberFormatException ex){
            err ="wrong_id_param";
          }
        }
        else{
          err = "id_value_404";
        }
      }
    }
    
    if (err != null){
      title = "Error";
    }
  %>
  <title><%=title%></title>

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
  if (err != null){
%>
<div class="container-fluid row">
  <div class = "page-header"><h3>Error : <%=err%></h3></div>
</div>
<%
  }
  else{
    if (submit){
      String nume = request.getParameter("nume");
      String prenume = request.getParameter("prenume");
      jb.connect();
      
      if (idProfesor > 0){
        String stergere = request.getParameter("stergere");
        if (stergere != null){
          String[] arr = {id};
          jb.stergeDataTabela(arr, "profesori", "idprofesor");  
          %>
          <div class="col-md-4">
            <h4> Profesoriul a fost sters cu succes</h4>
            <a class="btn btn-primary" href="lista_profesori.jsp" style="margin-top: 8px;" >Inapoi la profesori</a>
          </div>
          <%
        }
        else{
          jb.modificaProfesor(idProfesor, nume, prenume); 
          %>
          <div class="col-md-4">
            <h4> Profesorul a fost modificat cu succes</h4>
            <a class="btn btn-primary" href="vizualizare_profesor.jsp?id=<%=idProfesor%>" style="margin-top: 8px;" >Inapoi la profesor</a>
          </div>
          <%
        }
      }
      else{
        ResultSet rs = jb.adaugaProfesor(nume, prenume);
        %>
        <div class="col-md-4">
            <h4> Profesorul a fost adaugat cu succes</h4>
            <a class="btn btn-primary" href="vizualizare_profesor.jsp?id=<%=rs.getInt("idprofesor")%>" style="margin-top: 8px;">Vezi profesor</a>
          </div>
        <%
        rs.close();
      }
    }
    else
    {
      String nume = "";
      String prenume = "";
      if (idProfesor > 0){
        jb.connect();
        ResultSet rs = jb.intoarceLinieDupaId("profesori", "idprofesor", idProfesor);
        if(rs.next()){
          nume = rs.getString("nume");
          prenume = rs.getString("prenume");
        }
        rs.close();
      }
    
%>
<div class="container-fluid">
    <div class = "page-header">
      <h3><%=title%></h3>
    </div>
    <div class="col-md-4">
      <form role="form" method="post" action="modificare_profesor.jsp">
        <div class="form-group" style="margin-top: 8px;">
          <label for="nume">
            Nume
          </label>
          <input type="text" class="form-control" name="nume" value="<%=nume%>">
        </div>
        <div class="form-group" style="margin-top: 8px;">
          <label for="prenume">
            Prenume
          </label>
          <input type="text" class="form-control" name="prenume" value="<%=prenume%>">
        </div>
        <input type="hidden" name="idProfesor" value="<%=idProfesor%>">
        <button type="submit" class="btn btn-primary" style="margin-top: 8px;">
          Submit
        </button>
      </form>
    </div>
    
      <% if (idProfesor>0){ %>
    <div>
      
      <form role="form" method="post" action="modificare_profesor.jsp">
      <input type="hidden" name="idProfesor" value="<%=idProfesor%>">
      <input type="hidden" name="stergere" value="true">
      <button type="submit" class="btn btn-primary" style="margin-top: 8px;">Stergere</button>
      </form>
    </div>
      <%} %>
</div>
<%
  }}
  if(jb.isConnected()){
    jb.disconnect();
  }
%>
</body>
</html>