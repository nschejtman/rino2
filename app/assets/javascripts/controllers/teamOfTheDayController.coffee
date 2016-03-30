rinoApp = angular.module('rinoApp')

rinoApp.controller 'teamOfTheDayController',
  ['$scope', '$http', '$timeout'
    ($scope, $http, $timeout) ->
      drawer = new TodDrawer()

      $http.get('/api/tod').then(
        (resp) ->
          tod = resp.data
          $scope.goalkeeper = tod.goalkeeper
          $scope.leftBack = tod.leftBack
          $scope.rightBack = tod.rightBack
          $scope.leftMidfielder = tod.leftMidfielder
          $scope.rightMidfielder = tod.rightMidfielder
          $scope.striker = tod.striker
          drawer.draw([tod.goalkeeper, tod.leftBack, tod.rightBack, tod.leftMidfielder, tod.rightMidfielder, tod.striker])
      ,
        () ->
          notificationHandler.notifyError("Hubo un problema cargando el equipo actual")
      )


      $scope.create = () ->
        date = new Date()
        tod = {
          goalkeeper: $scope.goalkeeper,
          leftBack: $scope.leftBack,
          rightBack: $scope.rightBack,
          leftMidfielder: $scope.leftMidfielder,
          rightMidfielder: $scope.rightMidfielder,
          striker: $scope.striker
          "date.time": date.getTime()
        }
        $http.post('/api/tod', tod).then(
          () ->
            notificationHandler.notifySuccess("Equipo guardado correctamente")
        ,
          (errorResponse) ->
            ErrorResponseHandler.notify(errorResponse, notificationHandler)
        )


  ]