#Create the module
rinoApp = angular.module('rinoApp', [ 'ngRoute' ])

#Configure routes
rinoApp.config ($routeProvider) ->
  $routeProvider
  .when('/admin',
    templateUrl: '/admin'
    controller: 'mainController')
  .when '/categories',
    templateUrl: '/admin/categories'
    controller: 'categoriesController'

#Create controllers and inject Angular's $scope
rinoApp.controller 'mainController', ($scope) ->
  $scope.message = 'nico rocks'

rinoApp.controller 'categoriesController', ($scope) ->
  $scope.message = 'he is still rocking'
