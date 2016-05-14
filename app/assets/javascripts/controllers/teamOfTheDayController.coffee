rinoApp = angular.module('rinoApp')

rinoApp.controller 'teamOfTheDayController',
  ['$scope', '$http', '$timeout'
    ($scope, $http, $timeout) ->
      drawer = new TodDrawer()
      tod = null
      $scope.modal = new ModalUI($ '#saveConfirmModal')

      $http.get('/api/tod').then(
        (resp) ->
          tod = resp.data
          $scope.goalkeeper = tod.goalkeeper
          $scope.leftBack = tod.leftBack
          $scope.rightBack = tod.rightBack
          $scope.leftMidfielder = tod.leftMidfielder
          $scope.rightMidfielder = tod.rightMidfielder
          $scope.striker = tod.striker
          drawer.draw([tod.goalkeeper, tod.leftBack, tod.rightBack, tod.leftMidfielder, tod.rightMidfielder,
            tod.striker])
      ,
        () ->
          notificationHandler.notifyError("Hubo un problema con el servidor. Requerir asistencia.")
      )

      $scope.restore = () ->
        if(tod == null)
          notificationHandler.notifyError("No se encuentra el equipo anterior!")
        else
          $scope.goalkeeper = tod.goalkeeper
          $scope.leftBack = tod.leftBack
          $scope.rightBack = tod.rightBack
          $scope.leftMidfielder = tod.leftMidfielder
          $scope.rightMidfielder = tod.rightMidfielder
          $scope.striker = tod.striker
          drawer.draw([tod.goalkeeper, tod.leftBack, tod.rightBack, tod.leftMidfielder, tod.rightMidfielder,
            tod.striker])
          notificationHandler.notifySuccess("Se ha restaurado el equipo anterior")


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