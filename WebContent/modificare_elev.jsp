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
    int idElev = 0;
    String id = request.getParameter("idElev");
    if (id != null){
      submit = true;
    }
    
    if(submit){
      idElev = Integer.parseInt(id);
      if (idElev > 0){
        title = "Modificare elev";
      }
      else{
        title = "Adaugare elev";
      }
    }
    else {
	    id = request.getParameter("id");
	    String value = request.getParameter("value");
	    if(value != null){
	      title = "Adaugare elev";
	    }
	    else{
	      if (id != null){
	        try{
	          idElev = Integer.parseInt(id);
	          title = "Modificare elev";
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
      String an = request.getParameter("an");
      jb.connect();
      
      if (idElev > 0){
        String stergere = request.getParameter("stergere");
        if (stergere != null){
          String[] arr = {id};
          jb.stergeDataTabela(arr, "elevi", "idelev");  
          %>
          <div class="col-md-4">
            <h4> Elevul a fost sters cu succes</h4>
            <a class="btn btn-primary" href="lista_elevi.jsp" style="margin-top: 8px;" >Inapoi la elevi</a>
          </div>
          <%
        }
        else{
          jb.modificaElev(idElev, nume, prenume, Integer.parseInt(an)); 
          %>
          <div class="col-md-4">
            <h4> Elevul a fost modificat cu succes</h4>
            <a class="btn btn-primary" href="vizualizare_elev.jsp?id=<%=idElev%>" style="margin-top: 8px;" >Inapoi la elev</a>
          </div>
          <%
        }
      }
      else{
        ResultSet rs = jb.adaugaElev(nume, prenume, Integer.parseInt(an));
        %>
        <div class="col-md-4">
            <h4> Elevul a fost adaugat cu succes</h4>
            <a class="btn btn-primary" href="vizualizare_elev.jsp?id=<%=rs.getInt("idelev")%>" style="margin-top: 8px;">Vezi elev</a>
          </div>
        <%
        rs.close();
      }
    }
    else
    {
	    String nume = "";
	    String prenume = "";
	    int an = 0;
	    if (idElev > 0){
	      jb.connect();
	      ResultSet rs = jb.intoarceLinieDupaId("elevi", "idelev", idElev);
	      if(rs.next()){
	        nume = rs.getString("nume");
	        prenume = rs.getString("prenume");
	        an = rs.getInt("an");
	      }
	      rs.close();
	    }
    
%>
<div class="container-fluid">
    <div class = "page-header">
      <h3><%=title%></h3>
    </div>
    <div class="col-md-4">
      <form role="form" method="post" action="modificare_elev.jsp">
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
        <div class="form-group" style="margin-top: 8px;">
          <label for="an">
            An studii
          </label>
          <select class="selectpicker" name = "an">
            <%
            for(int i = 1; i <= 4; i++){
              if (i != an){
            %>
            <option value = "<%=i%>"><%=i%></option>  
            <%  }
              else{
            %>
            <option value = "<%=i%>" selected><%=i%></option>    
            <%
              }
            }
            %>
          </select>
        </div>
        <input type="hidden" name="idElev" value="<%=idElev%>">
        <button type="submit" class="btn btn-primary" style="margin-top: 8px;">
          Submit
        </button>
      </form>
    </div>
    
      <% if (idElev>0){ %>
    <div>
      
      <form role="form" method="post" action="modificare_elev.jsp">
      <input type="hidden" name="idElev" value="<%=idElev%>">
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