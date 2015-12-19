rinoApp = angular.module('rinoApp')

rinoApp.controller 'tournamentFixturesController',
  ['$scope', '$http', '$routeParams', 'tournaments',
    ($scope, $http, $routeParams, Tournament) ->
      $scope.tournament = Tournament.get({id: $routeParams.id})
      $matchAddModal = $ '#add-match-modal'
      $matchdayAddModal = $ '#add-matchday-modal'

      $scope.toggleMatchAddModal = (matchday) ->
        $scope.matchdayForAdd = matchday
        $matchAddModal.modal 'toggle'
        return false

      $scope.addMatch = ->
        data =
          "teamA.id": $scope.addTeamA
          "teamB.id": $scope.addTeamB
          "date.time": $scope.addDate.getTime() + $scope.addTime.getTime() + 3600000

        $http.put('/api/tournament/' + $scope.tournament.id + '/matchdays/' + $scope.matchdayForAdd.number + '/matches', data).then(
          (resp) ->
            $matchAddModal.modal 'toggle'
        )

      $scope.toggleMatchDay = (matchday) ->
        $http.get('/api/tournament/' + $scope.tournament.id + '/matchdays/' + matchday.number + '/matches').then(
          (resp) ->
            $scope.matches = resp.data
        )

      $scope.toggleMatchdayAddModal = ->
        $matchdayAddModal.modal 'toggle'
        return false

      $scope.addMatchday = ->
        data =
          id: null
          number: $scope.newMatchDayNumber

        $http.post('/api/tournament/' + $scope.tournament.id + '/matchdays', data).then(
          (resp) ->
            $scope.tournament.matchDays.push(resp.data)
            $matchdayAddModal.modal 'toggle'
        )

      $scope.getDate = (long) ->
        auxDate = new Date(long)
        return auxDate.getDate() + "/" + (auxDate.getMonth() + 1) + "/" + auxDate.getFullYear()

      $scope.getTime = (long) ->
        auxDate = new Date(long)
        addZero = (i) ->
          i = "0" + i if (i < 10)
          return i
        return addZero(auxDate.getHours()) + ":" + addZero(auxDate.getMinutes())

      $scope.deleteMatchday = (matchday, $index) ->
        $http.delete('/api/tournament/' + $scope.tournament.id + '/matchdays/' + matchday.number).then(
          (resp) ->
            $scope.tournament.matchDays.splice($index, 1)
          ,
          (msg) ->
            $.notify({
              # options
              message: msg.data
            },{
              # settings
              type: 'danger',
              animate: {
                enter: 'animated fadeInDown',
                exit: 'animated fadeOutUp'
              }
            });
          )
  ]
