<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html ng-app="appTemperatura">
<head>
	<title>Proyecto Piwelware</title>
	<link rel="stylesheet" type="text/css" href="../../resources/styles/boostrap.min.css">
	<link rel="stylesheet" type="text/css" href="../../resources/styles/boostrap-theme.min.css">
</head>
<body ng-controller="appController">
<form>
	<div>
			<h1>Temperatura</h1>
			<input type="text" id="ciudad" name="ciudad" 
			class="form-control" placeholder="Introduce población" autofocus required>
			<button type="button" class="btn btn-default" ng-click="verTiempo()">Ver el tiempo</button>
	</div>
	<div>
	
		<h4>Ciudad: {{temp.location.name}} ({{temp.location.region}})</h4>
		<h4>{{temp.location.country}}</h4>
		<img src="{{geo.current.condition.icon}}">
		<h5>{{temp.current.temp_c}} ºC</h5>
		<h5>{{temp.current.condition.text}}
		</h5>
	</div>
</form>
	<!-- AngularJS -->
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.6/angular.min.js"></script>

	<!-- AngularJS Locale (para Español) -->
	<script type="text/javascript"
		src="resources/scripts/angular-locale.min.js"></script>

	<script type="text/javascript">
		// Creacion del modulo principal de la aplicacion
		/*
		*	Servicio $scope => creacion del modelo (datos) para
		*	utilizar en la vista asociada al controlador
		*	
		*	Servicio $log => para depuración por consola del
		*	navegador. Equivalente a console.log
		*
		*	Servicio $http => para realizar peticiones asincronas
		*	a recursos (URL's) internas o externas. Por debajo va
		*	el objeto XMLHttpRequest
		*
		*	Se configura con un objeto donde indicamos el método
		*	de envio (porpiedad method) y la URL (propiedad url)
		*
		*	Tiene un callback asociado al evento success que se
		*	ejecuta cuando recibimos respuesta OK desde el
		*	servidor.
		*
		*	Tiene un callback asociado al evento error que se
		*	ejecuta cuando hay error en la respuesta desde el
		*	servidor.
		*/
		var servicios = angular.module("appTemperatura", []);
		
		// Creación del controlador principal
		var controlador = servicios.controller("appController",
				["$scope", "$log", "$http", 
					function($scope, $log, $http) {
					
					$scope.temp = {};
					
					$scope.verTiempo = function(ciudad) {
					
						var apiKey = "584dba877b3f417198b105657170610";
						var ciudad = document.getElementById("ciudad").value;
						url = "http://api.apixu.com/v1/current.json?key=" + apiKey + "&q=" + ciudad				
						
						/*
						*	Petición GET asíncrona para cargar los
						*	datos de la API de Apixu
						*/
						$http({
							method: 'GET',
							url: url
						}).success(function(datos, status, headers, config) {
							$scope.temp = datos;
							
						}).error(function(datos, status, headers, config) {
							
							alert("Error: Población no existente, vuélve a intentarlo.");
						});
						
						$log.debug("Creado scope del controlador");
					}
					
				}]);
	</script>
	
</body>
</html>
