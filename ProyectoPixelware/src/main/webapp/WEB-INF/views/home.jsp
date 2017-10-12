<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html ng-app="appTemperatura">
<head>
	<title>Proyecto Piwelware</title>
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<style type="text/css">
	body{
		background-image: url("resources/img/segovia.jpg"); 
		background-size:cover;
	    background-repeat: no-repeat;
	    background-attachment: fixed;
	    background-position: center; 
	}
	h1{
		color:white;
	}
	/*
		Por defecto la capa estará oculta.Hasta que no se introduce una ciudad correcta,
		no se mostrará.
	*/
		#datosTemperatura{
			display:none;
		}
	</style>
</head>
<body ng-controller="appController">
<div class="container">
	<div class="row">
		<div class="col-sm-offset-4 col-sm-4 col-sm-offset-4 text-center">
		<h1><i class="glyphicon glyphicon-cloud"></i> El tiempo</h1>
		<form class="form-inline">
			<div class="input-group">	
				<span class="input-group-addon"><i class="glyphicon glyphicon-search"></i></span>
				<input type="text" id="ciudad" name="ciudad" 
				class="form-control" placeholder="Introduce población" autofocus ng-model="introduceCiudad">
			</div>
			<button type="button" class="btn btn-success" ng-click="verTiempo()">Ver el tiempo</button>
		</div>
	</div>
	<div class="row" id="datosTemperatura" ng-style="mostrarTiempo">
		<div class="col-lg-6 text-center panel panel-default">
			<h3>Estás viendo el tiempo en {{temp.location.name}} ({{temp.location.region}}) {{temp.location.country | uppercase}}</h3>	
				<img ng-src="{{temp.current.condition.icon}}"/>
				<h3>{{temp.current.temp_c}} ºC</h3>
				<h4>{{temp.current.condition.text}}</h4>			
			<table class="table text-center">
			<thead class="text-center">
				<caption><h4>Más detalles</h4></caption>
				<tr>
					<th>Viento</th>
					<th>Humedad</th>
					<th>Presión atm.</th>
					<th>Sens. térmica</th>
				</tr>
			</thead>
			<tbody>
				<tr class="table-striped">
					<td>{{temp.current.wind_kph}} Km/h</td>
					<td>{{temp.current.humidity}} %</td>
					<td>{{temp.current.pressure_mb}} hPa</td>
					<td>{{temp.current.feelslike_c}} ºC</td>
				</tr>
			</tbody>
			</table>
		</div>
		<div class="col-lg-offset-1 col-lg-5 text-center panel panel-default">
			<table class="table text-center">
			<thead>
				<caption><h3>Historial 10 últimas consultas</h3></caption>
				<tr>
					<th>Ciudad</th>
					<th>Región</th>
					<th>País</th>
					<th>Temperatura</th>
				</tr>
			</thead>
			<tbody>
				<tr class="historial table-striped" ng-repeat="histTiempo in historial | orderBy:'-id':reverse | limitTo:10">
					<td>{{histTiempo.ciudad}}</td>
					<td>{{histTiempo.region}}</td>
					<td>{{histTiempo.pais}}</td>
					<td>{{histTiempo.temperatura}}</td>
				</tr>
			</tbody>
			</table>
		</div>
	</div>
</div>
	<!-- AngularJS -->
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.6/angular.min.js"></script>
	<script type="text/javascript">
		// Creacion del modulo principal de la aplicacion
		/*
		* Usamos la API de Apixu
		*/
		var servicios = angular.module("appTemperatura", []);
		
		// Creacion del controlador principal
		var controlador = servicios.controller("appController",
				["$scope", "$log", "$http", 
					function($scope, $log, $http) {
					
					
					//Creamos un objeto 'temp' para almacenar los datos del fichero JSON
					$scope.temp = {};
					
					//Crearemos un array 'historial' para el historial de búsquedas
					$scope.historial = [];
					
					//Para poder ordenar el listado de mayor a menor, usaremos una variable que
					//iniciaremos a 0
					$scope.id=0;
					
					//Al pulsar el botón 'Ver el tiempo', pasaremos por parámetro la ciudad
					$scope.verTiempo = function(ciudad) {
						
						//Almacenaremos en 'apiKey' la clave de la API de Apixu
						var apiKey = "584dba877b3f417198b105657170610";
						
						//Almacenaremos en 'ciudad' los datos introducidos en el campo 'ciudad'
						var ciudad = document.getElementById("ciudad").value;
						
						/*Con la URL del JSON,podemos sacar un fichero JSON con los datos del tiempo
						/de cada ciudad. 
						Leyendo en la propia API, existe un argumento llamado 'lang', podemos poner la 
						condición metereológica en castellano. 
					
						*/ 
						var url = "http://api.apixu.com/v1/current.json?key=" + apiKey + "&q=" + ciudad	+ "&lang=es"			
						
						/*
						*	Realizamos la peticion GET asincrona para cargar los
						*	datos de la API de Apixu
						*/
						$http({
							method: 'GET',
							url: url
						})
						
						//Comprobaremos que la ciudad introducida es correcta
						.success(function(datos, status, headers, config) {
							$scope.temp = datos;
							
							//Habilitamos la capa oculta que muestra los datos del tiempo							
							$scope.mostrarTiempo={
								    "display" : "block"
							}
							
							/*
							Vamos a crear un historial no persistente para mostrar el historial
							del usuario.
							*/
							
							//Vamos a incrementar la variable id cada vez que se añade una ciudad
							$scope.id++;
							
							//Guardaremos en un objeto todos los datos resumen que será presentado
							//en el historial.
							var anadirHistorial = {
										
									id : $scope.id,
									ciudad : $scope.temp.location.name,
									region : $scope.temp.location.region,
									pais : $scope.temp.location.country,
									temperatura : $scope.temp.current.temp_c + " ºC"
							}
							
							$scope.historial.push(anadirHistorial);
							
							//Borraremos el dato introducido del campo automáticamente para que 
							//posteriormente, no sea necesario borrarlo.
						    $scope.introduceCiudad = null;
							
						})
						//Comprobaremos que la ciudad introducida NO es correcta
						.error(function(datos, status, headers, config) {
							//Aparecerá un mensaje indicando que no es correcta la ciudad indicada.
							alert("Error: Poblacion no existente, vuelve a intentarlo.");
						});
						
						//Mediante consola podemos comprobar que la aplicación ha sido cargada correctamente
						$log.debug("La aplicación ha sido cargada correctamente.");
					}
					
				}]);
	</script>
</body>
</html>
