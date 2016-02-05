rinoApp = angular.module('rinoApp')

rinoApp.controller 'newsController',
  ['$scope',
    ($scope) ->
      $scope.hello = 'world'
  ]