<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html ng-app="appTemperatura">
<head>
	<title>Proyecto Piwelware</title>
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<style type="text/css">
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
<form>
	<h1>Temperatura</h1>	
	<form>
		<input type="text" id="ciudad" name="ciudad" 
		class="form-control" placeholder="Introduce población" autofocus>
		<button type="button" class="btn btn-default" ng-click="verTiempo()">Ver el tiempo</button>
	</form>	

	<div class="row" id="datosTemperatura" ng-style="mostrarTiempo">
		<div class="text-center">
			<h4>Estás viendo el tiempo en {{temp.location.name}} ({{temp.location.region}}) {{temp.location.country | uppercase}}</h4>	
				<img ng-src="{{temp.current.condition.icon}}"/>
				<h3>{{temp.current.temp_c}} ºC</h3>
				<h5>{{temp.current.condition.text}}</h5>
		</div>
	</div>
</form>
	<!-- AngularJS -->
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.6/angular.min.js"></script>

	<!-- AngularJS Locale (para Espanol) -->
	<script type="text/javascript"
		src="resources/scripts/angular-locale.min.js"></script>

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
					
					$scope.temp = {};
					
					$scope.verTiempo = function(ciudad) {
					
						var apiKey = "584dba877b3f417198b105657170610";
						var ciudad = document.getElementById("ciudad").value;
						var url = "http://api.apixu.com/v1/current.json?key=" + apiKey + "&q=" + ciudad				
						
						/*
						*	Peticion GET asincrona para cargar los
						*	datos de la API de Apixu
						*/
						$http({
							method: 'GET',
							url: url
						}).success(function(datos, status, headers, config) {
							$scope.temp = datos;
							
							/*
							Vamos a poner en castellano el tiempo actual, mediante un switch, 
							he modificado 2 tipos de condición metereológica. 
								Sunny -> Soleado
								Partly cloudy -> Parcialmente nublado	
							*/
							switch($scope.temp.current.condition.text){
							
							case "Sunny":
								$scope.temp.current.condition.text = "Soleado";
								break;

							case "Partly cloudy":
								$scope.temp.current.condition.text = "Parcialmente nublado";
								break;
								
							default:
								$scope.temp.current.condition.text
							}

							
							$scope.mostrarTiempo={
								    "display" : "block"
							}
							
						}).error(function(datos, status, headers, config) {
							
							alert("Error: Poblacion no existente, vuelve a intentarlo.");
						});
						
						$log.debug("Creado scope del controlador");
					}
					
				}]);
	</script>
	
</body>
</html>
