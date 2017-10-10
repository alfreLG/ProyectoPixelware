<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Proyecto Piwelware</title>
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
</head>
<body>
<form>


	<div class="row">
		<div class="col-md-offset-5 col-md-2 col-md-offset-5 text-center">
		<fieldset class="scheduler-border">
	    <legend class="scheduler-border">Proyecto Pixelware</legend>
				<input type="text" id="usuario" name="usuario" 
				class="form-control" placeholder="Usuario" autofocus required>
				
				<input type="password" id="password" name="password"
				class="form-control" placeholder="Contraseña" required>
				
				<button type="submit" id="btnValidarUsuario"  class="btn btn-default">Acceder</button>
				<button type="button" class="btn btn-success" data-toggle="modal" data-target="#myModal">Crear usuario</button>
		</fieldset>
		</div>
	</div>
	
	
  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Registro de usuarios</h4>
        </div>
        <div class="modal-body">
		<form>
				<input type="email" id="email" name="email" 
				class="form-control" placeholder="Correo Electrónico" autofocus required>
				
				<input type="password" id="password" name="password"
				class="form-control" placeholder="Contraseña" required>
				
				<input type="date" id="fechaNacimiento" name="fechaNacimiento"
				class="form-control" placeholder="Fecha nacimiento" required>
				
				<select id="paises" class="form-control">
					<option value="es">España</option>
					<option value="pt">Portugal</option>
				</select>
				
		</form>
        </div>
        <div class="modal-footer">
        <button type="submit" id="btnAnadirUsuario"  class="btn btn-success">Crear</button>
          <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
        </div>
      </div>
      
    </div>
  </div>	

</form>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
