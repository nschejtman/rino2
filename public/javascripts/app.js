//Create the module
var rinoApp = angular.module('rinoApp', ['ngRoute']);

//Configure routes
rinoApp.config(function($routeProvider){
    $routeProvider
        .when('/admin', {
            templateUrl : '/admin',
            controller : 'mainController'
        })
        .when('/categories', {
            templateUrl : '/admin/categories',
            controller : 'categoriesController'
        })
});

//Create controllers and inject Angular's $scope
rinoApp.controller('mainController', function($scope){
    $scope.message = 'nico rocks';
});

rinoApp.controller('categoriesController', function($scope){
   $scope.message = 'he is still rocking';
});