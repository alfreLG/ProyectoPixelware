package com.pixelware.proyecto.dao;
import java.sql.SQLException;
import java.util.List;
import com.pixelware.proyecto.model.Usuario;

public interface User {

	List<Usuario> getUsers() throws SQLException;

	Usuario getUserByCode(int code) throws SQLException;

	void crearUsuario(Usuario user) throws SQLException;

}
