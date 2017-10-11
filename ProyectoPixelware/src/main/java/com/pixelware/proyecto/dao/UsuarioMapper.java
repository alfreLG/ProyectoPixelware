package com.pixelware.proyecto.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;
import com.pixelware.proyecto.model.Usuario;


public class UsuarioMapper implements RowMapper<Usuario> {

	@Override
	public Usuario mapRow(ResultSet rs, int rowNum) throws SQLException {
		Usuario usuario = new Usuario(
				rs.getString("nombre"), 
				rs.getString("email"),
				rs.getString("contrasena"), 
				rs.getString("fechanacimiento")
				);

		return usuario;
	}

}
