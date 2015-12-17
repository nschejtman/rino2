rinoApp = angular.module('rinoApp')

rinoApp.controller 'tournamentFixturesController',
  ['$scope', '$http', '$routeParams', 'tournaments',
    ($scope, $http, $routeParams, Tournament) ->
      $scope.tournament = Tournament.get({id: $routeParams.id})
      $matchAddModal = $ '#add-match-modal'

      $scope.toggleMatchAddModal = (matchday) ->
        $scope.matchdayForAdd = matchday
        $matchAddModal.modal 'toggle'
        return false

      $scope.addMatch = ->
        data = {
          "teamA.id" : $scope.addTeamA,
          "teamB.id" : $scope.addTeamB,
          "date.time" : $scope.addDate.getTime() + $scope.addTime.getTime() + 3600000
        }
        $http.put('/api/tournament/' + $scope.tournament.id + '/matchdays/' + $scope.matchdayForAdd.id + '/matches', data).then(
          (resp) ->
            $matchAddModal.modal 'toggle'

        )

      $scope.toggleMatchDay = (matchday) ->
        $http.get('/api/tournament/' + $scope.tournament.id + '/matchdays/' + matchday.number + '/matches').then(
          (resp) ->
            $scope.matches = resp.data
        )


  ]
