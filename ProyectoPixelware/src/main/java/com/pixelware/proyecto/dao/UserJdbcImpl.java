package com.pixelware.proyecto.dao;

import java.sql.SQLException;
import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import com.pixelware.proyecto.model.Usuario;

/*
 * Versión de trabajo con JDBC mediante plantillas de Spring
 * para evitar código repetitivo en los métodos de negocio
 * (apertura y cierre de comexiones, liberación de objetos
 * utilizados,....)
 * 
 * Heredar de JdbcDaoSupport
 * 
 */
public class UserJdbcImpl extends JdbcDaoSupport implements User {

	@Override
	public void crearUsuario(Usuario user) {

		String insert = "INSERT INTO usuarios VALUES(?,?,?,?)";

		// Recuperar plantilla para trabajo con BBDD
		JdbcTemplate template = getJdbcTemplate();

		/*
		 * Para instrucciones NO SELECT método update()
		 * 
		 * Primer parámetro => SQL a ejecutar Segundo prámetro => Matriz de tipo
		 * Object con el valor de los parámetros
		 * 
		 */
		template.update(insert, new Object[] { user.getNombre(), user.getEmail(),
				user.getContrasena(), user.getFechanacimiento() });
	}

	@Override
	public List<Usuario> getUsers() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Usuario getUserByCode(int code) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

}
