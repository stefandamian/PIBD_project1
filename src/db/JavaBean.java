package db;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class JavaBean {
	private static final String[] cInstante = {"Elevi", "Discipline", "Profesori"};
	String error;
	Connection con;

	public JavaBean() {
	  con = null;
	}
	
	public boolean inInstante(String aInput) {
		return Arrays.stream(cInstante).anyMatch(aInput::equals);
	}
	
	public boolean isConnected() {
	  return con != null;
	}

	public void connect() throws ClassNotFoundException, SQLException, Exception {
		try {
		  if(isConnected()) {
		    disconnect();
		  }
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/proiect_pibd?useSSL=false", "root", "qwer1234");
		} catch (ClassNotFoundException cnfe) {
			error = "ClassNotFoundException: Nu s-a gasit driverul bazei de date.";
			throw new ClassNotFoundException(error);
		} catch (SQLException cnfe) {
			error = "SQLException: Nu se poate conecta la baza de date.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "Exception: A aparut o exceptie neprevazuta in timp ce se stabilea legatura la baza de date.";
			throw new Exception(error);
		}
	} // connect()

	public void disconnect() throws SQLException {
		try {
			if (con != null) {
				con.close();
				con = null;
			}
		} catch (SQLException sqle) {
			error = ("SQLException: Nu se poate inchide conexiunea la baza de date.");
			throw new SQLException(error);
		}
	} // disconnect()

	public ResultSet adaugaElev(String Nume, String Prenume, int An)
			throws SQLException, Exception {
		ResultSet rs = null;
	  if (con != null) {
			try {
				// create a prepared SQL statement
				Statement stmt, st;
				stmt = con.createStatement();
				stmt.executeUpdate("insert into elevi(nume, prenume, an) values('" + Nume + "'  , '" + Prenume + "', '" + An + "');");
				
				st = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
				rs=st.executeQuery("select * from elevi;");
				rs.last();

			} catch (SQLException sqle) {
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
		return rs; 
	} // end of adaugaElev()
	
	public void modificaElev(int id, String Nume, String Prenume, int An)
      throws SQLException, Exception {
    if (con != null) {
      try {
        // create a prepared SQL statement
        Statement stmt;
        stmt = con.createStatement();
        stmt.executeUpdate("UPDATE `proiect_pibd`.`elevi` SET nume = '" + Nume + "', `prenume` = '" + Prenume + "', `an` = '" + An + "' WHERE (`idelev` = '" + id + "');");

      } catch (SQLException sqle) {
        error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
        throw new SQLException(error);
      }
    } else {
      error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
      throw new Exception(error);
    }
  } // end of modificaElev()

	public ResultSet adaugaProfesor(String Nume, String Prenume)
			throws SQLException, Exception {
	  ResultSet rs = null;
		if (con != null) {
			try {
				// create a prepared SQL statement
				Statement stmt, st;
				stmt = con.createStatement();
				stmt.executeUpdate("insert into profesori(Nume, Prenume) values('" + Nume + "'  , '" + Prenume + "');");
				
				st = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        rs=st.executeQuery("select * from profesori;");
        rs.last();

			} catch (SQLException sqle) {
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
		return rs;
	} // end of adaugaProfesor()
	
	public void modificaProfesor(int id, String Nume, String Prenume)
      throws SQLException, Exception {
    if (con != null) {
      try {
        // create a prepared SQL statement
        Statement stmt;
        stmt = con.createStatement();
        stmt.executeUpdate("UPDATE profesori SET nume = '" + Nume + "', prenume = '" + Prenume + "' WHERE (`idprofesor` = '" + id + "');");

      } catch (SQLException sqle) {
        error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
        throw new SQLException(error);
      }
    } else {
      error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
      throw new Exception(error);
    }
  } // end of modificaProfesor()

	public ResultSet adaugaDisciplina(int idprofesor, String Nume)
			throws SQLException, Exception {
	  ResultSet rs = null;
		if (con != null) {
			try {
				// create a prepared SQL statement
				Statement stmt, st;
				stmt = con.createStatement();
				stmt.executeUpdate("insert into discipline(nume, idprofesor) values('" + Nume + "'  , '" + idprofesor + "');");
				
				st = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        rs=st.executeQuery("select * from discipline;");
        rs.last();

			} catch (SQLException sqle) {
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
		return rs;
	} // end of adaugaDisciplina()

	
	public void modificaDisciplina(int id, int idprofesor, String Nume)
      throws SQLException, Exception {
    if (con != null) {
      try {
        // create a prepared SQL statement
        Statement stmt;
        stmt = con.createStatement();
        stmt.executeUpdate("UPDATE discipline SET nume = '" + Nume + "', idprofesor = '" + idprofesor + "' WHERE (`iddisciplina` = '" + id + "');");

      } catch (SQLException sqle) {
        error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
        throw new SQLException(error);
      }
    } else {
      error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
      throw new Exception(error);
    }
  } // end of modificaDisciplina()
	
	public int numarEleviPerDisciplina(int iddisciplina)
      throws SQLException, Exception {
    int nr = 0;
    if (con != null) {
      try {
        // create a prepared SQL statement
        String queryString = ("SELECT a.nume, a.prenume, b.iddisciplina FROM elevi a, aranjamente b where a.idelev = b.idelev and b.iddisciplina = '" + iddisciplina + "';");
        Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        ResultSet rs = stmt.executeQuery(queryString);
        
        if (rs != null) {
          rs.last();
          nr = rs.getRow();
        }

      } catch (SQLException sqle) {
        error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
        throw new SQLException(error);
      }
    } else {
      error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
      throw new Exception(error);
    }
    return nr;
  } // end of numarEleviPerDisciplina()
	
	public int numarDisciplinePerProfesor(int idprofesor)
      throws SQLException, Exception {
    int nr = 0;
    if (con != null) {
      try {
        // create a prepared SQL statement
        String queryString = ("SELECT * FROM discipline where idprofesor = '" + idprofesor + "';");
        Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        ResultSet rs = stmt.executeQuery(queryString);
        
        if (rs != null) {
          rs.last();
          nr = rs.getRow();
        }

      } catch (SQLException sqle) {
        error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
        throw new SQLException(error);
      }
    } else {
      error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
      throw new Exception(error);
    }
    return nr;
  } // end of numarEleviPerDisciplina()
	
	public ResultSet adaugaAranjament(int iddisciplina, int idelev)
			throws SQLException, Exception {
	  ResultSet rs = null;
		if (con != null) {
			try {
				// create a prepared SQL statement
				Statement stmt, st;
				stmt = con.createStatement();
				stmt.executeUpdate("insert into aranjamente(iddisciplina, idelev) values('" + iddisciplina + "'  , '" + idelev + "');");
				
				st = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        rs=st.executeQuery("select * from aranjamente;");
        rs.last();

			} catch (SQLException sqle) {
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
		return rs;
	} // end of adaugaAranjament()
	
	public void modificaAranjament(int iddisciplinaOld, int idelevOld, int iddisciplinaNew, int idelevNew)
      throws SQLException, Exception {
    if (con != null) {
      try {
        // create a prepared SQL statement
        Statement stmt;
        stmt = con.createStatement();
        stmt.executeUpdate("UPDATE aranjamente SET iddisciplina = '" + iddisciplinaNew + "', idelev = '" + idelevNew + "' WHERE (iddisciplina = '" + iddisciplinaOld + "' and idelev = '" + idelevOld + "');");

      } catch (SQLException sqle) {
        error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
        throw new SQLException(error);
      }
    } else {
      error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
      throw new Exception(error);
    }
  } // end of modificaAranjament()
	
	public boolean existaAranjament(int iddisciplina, int idelev)
      throws SQLException, Exception {
	  boolean result = false;
	  if (con != null) {
      try {
        // create a prepared SQL statement
        Statement stmt;
        stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        ResultSet rs = stmt.executeQuery("select count(*) from aranjamente where iddisciplina = '" + iddisciplina + "' and idelev = '" + idelev + "';");
        rs.next();
        
        result = rs.getInt(1) > 0;
        rs.close();
        
      } catch (SQLException sqle) {
        error = "ExceptieSQL: Verificare nereusita";
        throw new SQLException(error);
      }
    } else {
      error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
      throw new Exception(error);
    }
	  return result;
	} // end of existaAranjament()

	public ResultSet vedeTabela(String tabel) throws SQLException, Exception {
		ResultSet rs = null;
		try {
			String queryString = ("select * from `proiect_pibd`.`" + tabel + "`;");
			Statement stmt = con.createStatement(/*ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY*/);
			rs = stmt.executeQuery(queryString);
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	} // vedeTabela()

	public void stergeDataTabela(String[] primaryKeys, String tabela, String dupaID) throws SQLException, Exception {
		if (con != null) {
			try {
				// create a prepared SQL statement
				long aux;
				PreparedStatement delete;
				delete = con.prepareStatement("DELETE FROM " + tabela + " WHERE " + dupaID + "=?;");
				for (int i = 0; i < primaryKeys.length; i++) {
					aux = java.lang.Long.parseLong(primaryKeys[i]);
					delete.setLong(1, aux);
					delete.execute();
				}
			} catch (SQLException sqle) {
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			} catch (Exception e) {
				error = "A aparut o exceptie in timp ce erau sterse inregistrarile.";
				throw new Exception(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
	} // end of stergeDateTabela()
	
	public void stergeAranjament(int iddisciplina, int idelev) throws SQLException, Exception {
    if (con != null) {
      try {
        // create a prepared SQL statement
        PreparedStatement delete;
        delete = con.prepareStatement("delete from aranjamente where idelev = " + idelev + " and iddisciplina = " + iddisciplina + ";");
        delete.execute();
      } catch (SQLException sqle) {
        error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
        throw new SQLException(error);
      } catch (Exception e) {
        error = "A aparut o exceptie in timp ce erau sterse inregistrarile.";
        throw new Exception(error);
      }
    } else {
      error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
      throw new Exception(error);
    }
  }
  
	public ResultSet intoarceLinieDupaId(String tabela, String denumireId1, int ID1, String denumireId2, int ID2) throws SQLException, Exception {
    ResultSet rs = null;
    try {
      // Execute query
      String queryString = ("select * from `proiect_pibd`.`" + tabela + "` where `" + denumireId1 + "` = " + ID1);
      if (ID2 > 0 & denumireId2 != null)
        queryString = queryString + " and " + denumireId1 + "` = " + ID1 + ";";
      else
        queryString = queryString + ";";
      Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
      rs = stmt.executeQuery(queryString); //sql exception
    } catch (SQLException sqle) {
      error = "SQLException: Interogarea nu a fost posibila.";
      throw new SQLException(error);
    } catch (Exception e) {
      error = "A aparut o exceptie in timp ce se extrageau datele.";
      throw new Exception(error);
    }
    return rs;
  } // end of intoarceLinieDupaId()
	
	public ResultSet intoarceLinieDupaId(String tabela, String denumireId, int ID) throws SQLException, Exception {
		return intoarceLinieDupaId(tabela, denumireId, ID, null, 0);
	} // end of intoarceLinieDupaId()
	
	public ResultSet getDisciplineForIdElev(int ID) throws SQLException, Exception {
	  ResultSet rs = null;
    try {
      // Execute query
      String queryString = ("select b.`iddisciplina` iddisciplina, b.`nume` numeDisciplina, c.`idprofesor` idprofesor, c.`nume` numeProfesor, c.`prenume` prenumeProfesor FROM proiect_pibd.`elevi` a, `discipline` b, `profesori` c, `aranjamente` d WHERE a.`idelev` = d.`idelev` and b.`iddisciplina` = d.`iddisciplina` and b.`idprofesor` = c.`idprofesor` and a.`idelev` = "+ ID + ";");
      Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
      rs = stmt.executeQuery(queryString); //sql exception
    } catch (SQLException sqle) {
      error = "SQLException: Interogarea nu a fost posibila.";
      throw new SQLException(error);
    } catch (Exception e) {
      error = "A aparut o exceptie in timp ce se extrageau datele.";
      throw new Exception(error);
    }
    return rs;
	}
	
	public ResultSet getTheRestDisciplineForIdElev(int ID) throws SQLException, Exception {
	  ResultSet rs = null;
    try {
      // Execute query
      String queryString = ("select iddisciplina from discipline;");
      Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
      rs = stmt.executeQuery(queryString); //sql exception
      List<String> arr = new ArrayList<String>();
      while(rs.next())
      {
        arr.add(String.valueOf(rs.getInt("iddisciplina")));
      }
      rs.close();
      
      queryString = ("select b.`iddisciplina` iddisciplina, b.`nume` numeDisciplina, c.`idprofesor` idprofesor, c.`nume` numeProfesor, c.`prenume` prenumeProfesor FROM proiect_pibd.`elevi` a, `discipline` b, `profesori` c, `aranjamente` d WHERE a.`idelev` = d.`idelev` and b.`iddisciplina` = d.`iddisciplina` and b.`idprofesor` = c.`idprofesor` and a.`idelev` = "+ ID + ";");
      stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
      rs = stmt.executeQuery(queryString); //sql exception
      while(rs.next())
      {
        arr.remove(String.valueOf(rs.getInt("iddisciplina")));
      }
      rs.close();
      
      queryString = "select b.iddisciplina iddisciplina, b.nume numeDisciplina, c.`idprofesor` idprofesor, c.`nume` numeProfesor, c.`prenume` prenumeProfesor FROM discipline b, profesori c WHERE c.idprofesor = b.idprofesor and b.iddisciplina in (";
      if (arr.size() > 0) {  
        queryString = queryString + String.join(", ", arr) + ");";
        stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        rs = stmt.executeQuery(queryString); //sql exception
      }
      else {
        rs = null;
      }
      
    } catch (SQLException sqle) {
      error = "SQLException: Interogarea nu a fost posibila.";
      throw new SQLException(error);
    } catch (Exception e) {
      error = "A aparut o exceptie in timp ce se extrageau datele.";
      throw new Exception(error);
    }
    return rs;
  }
	
	public ResultSet getTheRestEleviForIdDisciplina(int ID) throws SQLException, Exception {
    ResultSet rs = null;
    try {
      // Execute query
      String queryString = ("select idelev from elevi;");
      Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
      rs = stmt.executeQuery(queryString); //sql exception
      List<String> arr = new ArrayList<String>();
      while(rs.next())
      {
        arr.add(String.valueOf(rs.getInt("idelev")));
      }
      rs.close();
      
      queryString = ("select a.`idelev` idelev FROM proiect_pibd.`elevi` a, `discipline` b, `aranjamente` d WHERE a.`idelev` = d.`idelev` and b.`iddisciplina` = d.`iddisciplina` and b.`iddisciplina` = "+ ID + ";");
      stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
      rs = stmt.executeQuery(queryString); //sql exception
      while(rs.next())
      {
        arr.remove(String.valueOf(rs.getInt("idelev")));
      }
      rs.close();
      
      queryString = "select * FROM elevi WHERE idelev in (";
      if (arr.size() > 0) {  
        queryString = queryString + String.join(", ", arr) + ");";
        stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        rs = stmt.executeQuery(queryString); //sql exception
      }
      else {
        rs = null;
      }
      
    } catch (SQLException sqle) {
      error = "SQLException: Interogarea nu a fost posibila.";
      throw new SQLException(error);
    } catch (Exception e) {
      error = "A aparut o exceptie in timp ce se extrageau datele.";
      throw new Exception(error);
    }
    return rs;
  }
	
	public ResultSet getEleviForIdDisciplina(int ID) throws SQLException, Exception {
    ResultSet rs = null;
    try {
      // Execute query
      String queryString = ("select a.idelev idelev, a.nume numeElev, a.prenume prenumeElev, a.an anElev FROM elevi a, aranjamente b WHERE a.idelev = b.idelev and b.iddisciplina = '" + ID + "';");
      Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
      rs = stmt.executeQuery(queryString); //sql exception
    } catch (SQLException sqle) {
      error = "SQLException: Interogarea nu a fost posibila.";
      throw new SQLException(error);
    } catch (Exception e) {
      error = "A aparut o exceptie in timp ce se extrageau datele.";
      throw new Exception(error);
    }
    return rs;
  }
}
