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

      $scope.removeTeam = (team, $index) ->
        $http.put('/api/tournaments/' + $routeParams.id + '/removeTeam/' + team.id).then(->
          $scope.tournament.teams.splice($index, 1)
          $scope.availableTeams.push(team)
        )

      removeTeamFromAvailableTeams = (team) ->
        idx = $scope.availableTeams.indexOf(team)
        $scope.availableTeams.splice(idx, 1)

      setData = () ->
        $scope.tournament = Tournament.get({id: $routeParams.id}, updateAvailableTeamsForTournament)

      updateAvailableTeamsForTournament = (tournament) ->
        $scope.availableTeams = Team.query(
          () -> $scope.availableTeams = $scope.availableTeams.filter(
            (team) -> !tournament.teams.map((t) -> t.id).includes(team.id)
          )
        )


      setData()
  ]