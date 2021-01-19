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

    <title>Vizualizare disciplina</title>

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
        Vizualizare disciplina
      </h1>
    </div>
    <%
      String iddisciplina = request.getParameter("id");
      int value = 0;
      if(iddisciplina != null){
        value = Integer.parseInt(iddisciplina);
      }
      jb.connect();
      if(value > 0){
        ResultSet rs = jb.intoarceLinieDupaId("discipline", "iddisciplina", value);
        if (rs!=null)
          rs.next();
        ResultSet rs2 = jb.intoarceLinieDupaId("profesori", "idprofesor", rs.getInt("idprofesor"));
        if (rs2 != null)
          rs2.next();
            
    %>
    <div class="row" style="margin-top: 30px;">
      <div class = "col-md-5 float_left">
        <h3>Nume: <%=rs.getString("nume")%></h3>
        <h3>Profesor: <%= rs2.getString("nume")%> <%= rs2.getString("prenume")%></h3>
        <a class="btn btn-primary" href="modificare_disciplina.jsp?id=<%=value%>">Modificare Disciplina</a>
        <a class="btn btn-primary" href="vizualizare_profesor.jsp?id=<%=rs2.getInt("idprofesor")%>">Vizualizare Profesor</a>
      </div>
      <div class = "col-md-7 float_right">
        <table class="table table-bordered table-sm">
          <thead>
            <tr>
              <th>#</th>
              <th>Nume</th>
              <th>Prenume</th>
              <th>An</th>
            </tr>
          </thead>
          <tbody>
            <%
            rs.close();
            rs2.close();
            rs = jb.getEleviForIdDisciplina(value);
            long x;
            long i = 0;
            while (rs.next()) {
                x = rs.getInt("idelev");
                if((i % 2) == 0){
            %>  
            <tr class="table-active">
            <% } else { %>
            <tr>
            <% }
              i = i + 1; %>
              <td><%=i%></td>
              <td><%=rs.getString("numeElev")%></td>
              <td><%=rs.getString("prenumeElev")%></td>
              <td><%=rs.getString("anElev")%></td>
              <td>
                <a href="vizualizare_elev.jsp?id=<%=x%>" class="btn btn-primary float_right">Vizualizare Elev</a>
              </td>
            </tr>
            <%
              } 
            %>
          </tbody>
        </table>
        <a href="adaugare_aranjament_elev-disciplina.jsp?idDisciplina=<%=value%>" class="btn btn-primary float_right">Adaugare Elev</a>
        <a href="stergere_aranjament_elev-disciplina.jsp?idDisciplina=<%=value%>" class="btn btn-primary float_right">Elimina Elev</a>
      </div>
    </div>
    <%
        rs.close();
      }
      else{
    %>
    <div class="page-header">
      <h1>Disciplina nu a putut fi accesata</h1>
    </div>
    <%
        }
      jb.disconnect();
    %>
</div>
</body>
</html>