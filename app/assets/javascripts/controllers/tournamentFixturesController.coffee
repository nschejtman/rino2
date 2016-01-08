rinoApp = angular.module('rinoApp')

rinoApp.controller 'tournamentFixturesController',
  ['$scope', '$http', '$routeParams', 'tournaments',
    ($scope, $http, $routeParams, Tournament) ->
      $scope.tournament = Tournament.get({id: $routeParams.id})
      $matchAddModal = $ '#add-match-modal'
      $matchdayModal = $ '#matchday-modal'
      $matchdayModalTitle = $matchdayModal.find('.modal-title')


      $scope.toggleMatchAddModal = (matchday) ->
        $scope.matchdayForAdd = matchday
        $matchAddModal.modal 'toggle'
        return false

      $scope.addMatch = ->
        data =
          "teamA.id": $scope.addTeamA
          "teamB.id": $scope.addTeamB
          "date.time": (if $scope.addDate != undefined && $scope.addTime != undefined then ($scope.addDate.getTime() + $scope.addTime.getTime() + 3600000) else null)

        $http.put('/api/tournament/' + $scope.tournament.id + '/matchdays/' + $scope.matchdayForAdd.number + '/matches', data).then(
          (resp) ->
            $matchAddModal.modal 'toggle'
          ,
          (errorResponse) ->
            errorHandler.handle(errorResponse, $matchAddModal)
        )

      $scope.toggleMatchDay = (matchday) ->
        $http.get('/api/tournament/' + $scope.tournament.id + '/matchdays/' + matchday.number + '/matches').then(
          (resp) ->
            $scope.matches = resp.data
        )

      $scope.toggleMatchdayAddModal = ->
        $matchdayModal.modal 'toggle'
        $matchdayModalTitle.html "Nueva Fecha"
        $scope.newMatchDayNumber = ''
        $scope.confirmMatchdayModal = addMatchday
        return false

      addMatchday = ->
        data =
          id: null
          number: (if $scope.newMatchDayNumber != "" then $scope.newMatchDayNumber else null)

        $http.post('/api/tournament/' + $scope.tournament.id + '/matchdays', data).then(
          (resp) ->
            $scope.tournament.matchDays.push(resp.data)
            $matchdayModal.modal 'toggle'
        ,
          (errorResponse) ->
            errorHandler.handle(errorResponse, $matchdayModal)
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
              message: msg.data
            }, {
              type: 'danger',
              animate: {
                enter: 'animated fadeInDown',
                exit: 'animated fadeOutUp'
              }
            });
        )

      $scope.toggleMatchdayEditModal = (matchday) ->
        $scope.matchdayForEdit = matchday
        $matchdayModalTitle.html "Editar fecha"
        $scope.newMatchDayNumber = matchday.number
        $matchdayModal.modal 'toggle'
        $scope.confirmMatchdayModal = editMatchday


      editMatchday = ->
        previousN = $scope.matchdayForEdit.number
        $scope.matchdayForEdit.number = $scope.newMatchDayNumber
        $http.put('/api/tournament/' + $scope.tournament.id + '/matchdays/' + previousN, $scope.matchdayForEdit).then(
          (resp) ->
            $matchdayModal.modal 'toggle',
              (errors) ->
            $scope.matchdayForEdit.number = previousN
        )
  ]
