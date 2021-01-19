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
    String title = null;
    String err = null;
    String idElev = request.getParameter("idElev");
    String idDisciplina = request.getParameter("idDisciplina");
    String add = request.getParameter("value");
    
    if (add != null)
      title = "Adaugare Aranjament";
    else{
      if (idElev == null)
        err = "elev404";
      if (idDisciplina == null)
        err = "disciplina404";
      if (err == null)
        title = "Modificare Aranjament";
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
    if (request.getParameter("submit") != null){
      String idElevNew = request.getParameter("idElevNew");
      String idDisciplinaNew = request.getParameter("idDisciplinaNew");
      jb.connect();
      
      if(!jb.existaAranjament(Integer.parseInt(idDisciplinaNew), Integer.parseInt(idElevNew))){
	      if (add == null){
	        jb.modificaAranjament(Integer.parseInt(idDisciplina), Integer.parseInt(idElev), Integer.parseInt(idDisciplinaNew), Integer.parseInt(idElevNew)); 
	        %>
	        <div class="col-md-4">
	          <h4> Aranjamentul a fost modificat cu succes</h4>
	          <a class="btn btn-primary" href="lista_aranjamente.jsp" style="margin-top: 8px;" >Lista aranjamente</a>
	        </div>
	        <%
	      }
	      else{
	        jb.adaugaAranjament(Integer.parseInt(idDisciplinaNew), Integer.parseInt(idElevNew));
	        %>
	        <div class="col-md-4">
	            <h4> Aranjamentul a fost adaugat cu succes</h4>
	            <a class="btn btn-primary" href="lista_aranjamente.jsp" style="margin-top: 8px;" >Lista aranjamente</a>
	        </div>
	        <%
	      }
      }
      else{
        ResultSet rsElev = jb.intoarceLinieDupaId("elevi", "idelev", Integer.parseInt(idElevNew));
        ResultSet rsDisciplina = jb.intoarceLinieDupaId("discipline", "iddisciplina", Integer.parseInt(idDisciplinaNew));
        if (rsElev != null)
          rsElev.next();
        if (rsDisciplina != null)
          rsDisciplina.next();
        %>
        <div class="col-md-4">
          <h4> Aranjamentul (Elev - <%=rsElev.getString("nume")%> <%=rsElev.getString("prenume")%>, Disciplina - <%=rsDisciplina.getString("nume")%>) este deja existent in baza de date.</h4>
          <a class="btn btn-primary" href="lista_aranjamente.jsp" style="margin-top: 8px;" >Lista aranjamente</a>
        </div>
        <%
      }
    }
    else
    {
      jb.connect();
    
%>
<div class="container-fluid">
    <div class = "page-header">
      <h3><%=title%></h3>
    </div>
    <div class="col-md-4">
      <form role="form" method="post" action="modificare_aranjament.jsp">
        <div class="form-group" style="margin-top: 8px;">
          <label for="idElevNew">
            Elev
          </label>
          <select class="selectpicker" name = "idElevNew">
            <%
            ResultSet rsElev = jb.vedeTabela("elevi");
            int selected = 0;
            if (idElev != null)
              selected = Integer.parseInt(idElev); 
            while(rsElev.next()){
              int idelev = rsElev.getInt("idelev");
              
              if(idelev != selected){
            %>
            <option value = "<%=idelev%>"><%=rsElev.getString("nume")%> <%=rsElev.getString("prenume")%></option>  
            <%  }
              else{
            %>
            <option value = "<%=idelev%>" selected><%=rsElev.getString("nume")%> <%=rsElev.getString("prenume")%></option>    
            <%
              }
            }
            %>
          </select>
        </div>
        <div class="form-group" style="margin-top: 8px;">
          <label for="idDisciplinaNew">
            Disciplina
          </label>
          <select class="selectpicker" name = "idDisciplinaNew">
            <%
            ResultSet rsDisciplina = jb.vedeTabela("discipline");
            selected = 0;
            if (idDisciplina != null)
              selected = Integer.parseInt(idDisciplina); 
            while(rsDisciplina.next()){
              int iddisciplina = rsDisciplina.getInt("iddisciplina");
              if(iddisciplina != selected){
            %>
            <option value = "<%=iddisciplina%>"><%=rsDisciplina.getString("nume")%></option>  
            <%  }
              else{
            %>
            <option value = "<%=iddisciplina%>" selected><%=rsDisciplina.getString("nume")%></option>    
            <%
              }
            }
            %>
          </select>
        </div>
        <input type="hidden" name="submit" value="true">
        <%if (add == null){%>
        <input type="hidden" name="idElev" value="<%=Integer.parseInt(idElev)%>">
        <input type="hidden" name="idDisciplina" value="<%=Integer.parseInt(idDisciplina)%>">
        <%
        } else {
        %>
        <input type="hidden" name="value" value="add">
        <% } %>
        <button type="submit" class="btn btn-primary" style="margin-top: 8px;">
          Submit
        </button>
      </form>
    </div>
</div>
<%
  }}
  if(jb.isConnected()){
    jb.disconnect();
  }
%>
</body>
</html>