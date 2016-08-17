rinoApp = angular.module('rinoApp')

rinoApp.controller 'tournamentTeamsController',
  ['$scope', '$http', '$routeParams', 'tournaments', 'teams',
    ($scope, $http, $routeParams, Tournament, Team) ->
      $modal = $ '#modal'

      $scope.toggleModal = () ->
        $modal.modal 'toggle'
        return false

      $scope.addTeam = ->
        $http.put('/api/tournaments/' + $routeParams.id + '/addTeam/' + $scope.selectedTeam.id).then(->
          $scope.tournament.teams.push($scope.selectedTeam)
          removeTeamFromAvailableTeams($scope.selectedTeam)
          $scope.toggleModal()
        )

      $scope.removeTeam = (teamId, $index) ->
        $http.put('/api/tournaments/' + $routeParams.id + '/removeTeam/' + teamId).then(->
          $scope.tournament.teams.splice($index, 1)
        )

      removeTeamFromAvailableTeams = (team) ->
        idx = $scope.teams.indexOf(team)
        $scope.teams.splice(idx, 1)

      setData = () ->
        $scope.tournament = Tournament.get({id: $routeParams.id}, (tournament) ->
          $scope.availableTeams = Team.query(
            () -> $scope.availableTeams = $scope.availableTeams.filter(
              (team) -> !tournament.teams.map((t) -> t.id).includes(team.id)
            )
          )
        )

      setData()
  ]