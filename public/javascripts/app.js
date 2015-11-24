//create the module
var rinoApp = angular.module('rinoApp', []);

//create the controller and inject Angular's $scope
rinoApp.controller('mainController', function($scope){$scope.message = 'nico rocks';});
