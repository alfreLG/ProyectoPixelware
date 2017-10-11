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
<div class="container">
	<div class="row">
		<div class="col-sm-offset-4 col-sm-4 col-sm-offset-4 text-center" style="margin-top:15%;">
		<h1><i class="glyphicon glyphicon-cloud"></i> El tiempo</h1>
		<form class="form-inline">
			<div class="input-group">	
				<span class="input-group-addon"><i class="glyphicon glyphicon-search"></i></span>
				<input type="text" id="ciudad" name="ciudad" 
				class="form-control" placeholder="Introduce población" autofocus>
			</div>
			<button type="button" class="btn btn-success" ng-click="verTiempo()">Ver el tiempo</button>
		</div>
	</div>
	<div class="row" id="datosTemperatura" ng-style="mostrarTiempo">
		<div class="col-lg-6 text-center">
			<h4>Estás viendo el tiempo en {{temp.location.name}} ({{temp.location.region}}) {{temp.location.country | uppercase}}</h4>	
				<img ng-src="{{temp.current.condition.icon}}"/>
				<h3>{{temp.current.temp_c}} ºC</h3>
				<h4>{{temp.current.condition.text}}</h4>
		</div>
	

		<div class="col-lg-6 text-center">
			<table class="table">
			<thead>
				<caption>Historial 10 últimas consultas</caption>
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
<!--   https://www.mkyong.com/spring/maven-spring-jdbc-example/ -->
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
					
					$scope.temp = {};
					$scope.historial = [];
					$scope.id=0;
					
					$scope.verTiempo = function(ciudad) {
					
						var apiKey = "584dba877b3f417198b105657170610";
						var ciudad = document.getElementById("ciudad").value;
						var url = "http://api.apixu.com/v1/current.json?key=" + apiKey + "&q=" + ciudad	+ "&lang=es"			
						
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


							// Al comprobar que ha introducido una población correcta, se habilita
							// la capa.
							
							$scope.mostrarTiempo={
								    "display" : "block"
							}
							
							/*
							Vamos a crear un historial no persistente para mostrar el historial
							del usuario.
							*/
									
							$scope.id++;
							
							var anadirHistorial = {
										
									id : $scope.id,
									ciudad : $scope.temp.location.name,
									region : $scope.temp.location.region,
									pais : $scope.temp.location.country,
									temperatura : $scope.temp.current.temp_c + " ºC"
							}
							
							$scope.historial.push(anadirHistorial);
							
							
						}).error(function(datos, status, headers, config) {
							
							alert("Error: Poblacion no existente, vuelve a intentarlo.");
						});
						
						$log.debug("Creado scope del controlador");
					}
					
				}]);
	</script>
	
</body>
</html>
