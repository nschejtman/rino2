rinoApp = angular.module('rinoApp')

rinoApp.controller 'tournamentFixturesController',
  ['$scope', '$http', '$routeParams', 'tournaments',
    ($scope, $http, $routeParams, Tournament) ->
      $scope.tournament = Tournament.get({id: $routeParams.id})
  ]
