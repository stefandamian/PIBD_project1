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
    int idDisciplina = 0;
    String id = request.getParameter("idDisciplina");
    if (id != null){
      submit = true;
    }
    
    if(submit){
      idDisciplina = Integer.parseInt(id);
      if (idDisciplina > 0){
        title = "Modificare disciplina";
      }
      else{
        title = "Adaugare disciplina";
      }
    }
    else {
      id = request.getParameter("id");
      String value = request.getParameter("value");
      if(value != null){
        title = "Adaugare disciplina";
      }
      else{
        if (id != null){
          try{
            idDisciplina = Integer.parseInt(id);
            title = "Modificare disciplina";
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
      String idProf = request.getParameter("idprofesor");
      jb.connect();
      
      if (idDisciplina > 0){
        String stergere = request.getParameter("stergere");
        if (stergere != null){
          String[] arr = {id};
          jb.stergeDataTabela(arr, "discipline", "iddisciplina");  
          %>
          <div class="col-md-4">
            <h4> Disciplina a fost stearsa cu succes</h4>
            <a class="btn btn-primary" href="lista_discipline.jsp" style="margin-top: 8px;" >Inapoi la discipline</a>
          </div>
          <%
        }
        else{
          jb.modificaDisciplina(idDisciplina, Integer.parseInt(idProf), nume); 
          %>
          <div class="col-md-4">
            <h4> Disciplina a fost modificata cu succes</h4>
            <a class="btn btn-primary" href="vizualizare_disciplina.jsp?id=<%=idDisciplina%>" style="margin-top: 8px;" >Inapoi la disciplina</a>
          </div>
          <%
        }
      }
      else{
        ResultSet rs = jb.adaugaDisciplina(Integer.parseInt(idProf), nume);
        %>
        <div class="col-md-4">
            <h4> Disciplina a fost adaugata cu succes</h4>
            <a class="btn btn-primary" href="vizualizare_disciplina.jsp?id=<%=rs.getInt("iddisciplina")%>" style="margin-top: 8px;">Vezi disciplina</a>
          </div>
        <%
        rs.close();
      }
    }
    else
    {
      String nume = "";
      int idprofesor = 0;
      if (idDisciplina > 0){
        jb.connect();
        ResultSet rs = jb.intoarceLinieDupaId("discipline", "iddisciplina", idDisciplina);
        if(rs.next()){
          nume = rs.getString("nume");
          idprofesor = rs.getInt("idprofesor");
        }
        rs.close();
        jb.disconnect();
      }
    
%>
<div class="container-fluid">
    <div class = "page-header">
      <h3><%=title%></h3>
    </div>
    <div class="col-md-4">
      <form role="form" method="post" action="modificare_disciplina.jsp">
        <div class="form-group" style="margin-top: 8px;">
          <label for="nume">
            Nume
          </label>
          <input type="text" class="form-control" name="nume" value="<%=nume%>">
        </div>
        <div class="form-group" style="margin-top: 8px;">
          <label for="idprofesor">
            Profesor
          </label>
          <select class="selectpicker" name = "idprofesor">
            <%
              jb.connect();
              ResultSet rs = jb.vedeTabela("profesori");
              
              int idProf = 0;
              if(idDisciplina > 0){
                ResultSet rs1 = jb.intoarceLinieDupaId("discipline", "iddisciplina", idDisciplina);
                if(rs1 != null)
                  rs1.next();
                idProf = rs1.getInt("idprofesor");
              }
              
              while(rs.next()){
                int i = rs.getInt("idprofesor");
                if(i != idProf){
            %>
            <option value = "<%=i%>"><%=rs.getString("nume")%> <%=rs.getString("prenume")%></option>  
            <%  }
                else{
            %>
            <option value = "<%=i%>" selected><%=rs.getString("nume")%> <%=rs.getString("prenume")%></option>    
            <%
              }
            }
              jb.disconnect();
              rs.close();
            %>
          </select>
        </div>
        <input type="hidden" name="idDisciplina" value="<%=idDisciplina%>">
        <button type="submit" class="btn btn-primary" style="margin-top: 8px;">
          Submit
        </button>
      </form>
    </div>
    
      <% if (idDisciplina > 0){ %>
    <div>
      
      <form role="form" method="post" action="modificare_disciplina.jsp">
      <input type="hidden" name="idDisciplina" value="<%=idDisciplina%>">
      <input type="hidden" name="stergere" value="true">
      <button type="submit" class="btn btn-primary" style="margin-top: 8px;">Stergere</button>
      </form>
    </div>
      <%} %>
</div>
<%
  }}
  jb.disconnect();
%>
</body>
</html>