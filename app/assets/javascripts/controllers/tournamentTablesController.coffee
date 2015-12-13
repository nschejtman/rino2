rinoApp = angular.module('rinoApp')

rinoApp.controller 'tournamentTablesController',
  ['$scope', '$routeParams', 'tournaments',
    ($scope, $routeParams, Tournament) ->
      $scope.tournament = Tournament.get({id: $routeParams.id})
      $scope.message = "asd"
      $scope.asdasd = {id: 1, name: 'asdasd'}
  ]