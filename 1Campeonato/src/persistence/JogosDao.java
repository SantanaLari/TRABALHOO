package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Jogos;

public class JogosDao implements IJogosDao {

	private GenericDao gDao;
	
	public JogosDao(GenericDao gDao) {
		this.gDao = gDao;
	}
	
	@Override
	public String excluirJogos() throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "DELETE jogos";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.execute();
		ps.close();
		c.close();
		return "Jogos excluidos";
	}

	@Override
	public List<Jogos> consultaJogos() throws SQLException, ClassNotFoundException {
		List<Jogos> jogos = new ArrayList<Jogos>();
		
		Connection c = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT CodigoTimeA, CodigoTimeB ");
		sql.append("FROM jogos jg ");
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			Jogos j = new Jogos();
			j.setCodigoTimeA(rs.getInt("CodigoTimeA"));
			j.setCodigoTimeB(rs.getInt("CodigoTimeB"));
			
			jogos.add(j);
		}
		
		rs.close();
		ps.close();
		c.close();
		
		return jogos;
	}

}
