rinoApp = angular.module('rinoApp')

rinoApp.controller 'teamOfTheDayController',
  ['$scope',
    ($scope) ->
      todDrawer = new TodDrawer()
      todDrawer.main();
      $scope.asd = "Hello world"
      return

  ]