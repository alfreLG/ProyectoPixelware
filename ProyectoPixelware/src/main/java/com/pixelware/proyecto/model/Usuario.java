package com.pixelware.proyecto.model;

import java.io.Serializable;
import java.util.Date;

public class Usuario implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String nombre;
	private String email;
	private String contrasena;
	private String fechanacimiento;
	

	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getContrasena() {
		return contrasena;
	}
	public void setContrasena(String contrasena) {
		this.contrasena = contrasena;
	}
	public String getFechanacimiento() {
		return fechanacimiento;
	}
	public void setFechanacimiento(String fechanacimiento) {
		this.fechanacimiento = fechanacimiento;
	}
		
}
