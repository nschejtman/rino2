rinoApp = angular.module('rinoApp')

rinoApp.controller 'tournamentTeamsController',
  ['$scope', '$http', '$routeParams', 'tournaments', 'teams',
    ($scope, $http, $routeParams, Tournament, Team) ->
      $scope.tournament = Tournament.get({id: $routeParams.id})
      $scope.teams = Team.query()
      $modal = $ '#modal'
      $teamInput = $modal.find('select')

      $scope.toggleModal = () ->
        $modal.modal 'toggle'
        return false

      $scope.addTeam = ->
        $http.put('/api/tournaments/' + $routeParams.id + '/addTeam/' + $teamInput.val()).then( ->
          $scope.tournament.teams.push({id: $teamInput.val(), name: $teamInput.find('option:selected').html()})
          $scope.toggleModal()
        )

      $scope.removeTeam = (teamId, $index) ->
        $http.put('/api/tournaments/' + $routeParams.id + '/removeTeam/' + teamId).then( ->
          $scope.tournament.teams.splice($index, 1)
        )
  ]