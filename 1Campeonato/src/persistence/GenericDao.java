package persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class GenericDao {

private Connection c;
	
	public Connection getConnection() throws ClassNotFoundException, SQLException {
		
		String hostName = "localhost";
		String dbName = "exviewjavaservletsonibus";
		String user = "Larissa";
		String senha = "P4ssw0rd";
		
		Class.forName("net.sourceforge.jtds.jdbc.Driver");
		c = 
	    DriverManager.getConnection("jdbc:jtds:sqlserver://localhost:1433/av_teste;instance=sqlexpress;user=Larissa;password=1234567");

		return c;
	}
}

//avaliacao_LBD1