rinoApp = angular.module('rinoApp')

rinoApp.controller 'teamPlayersController',
  ['$scope', '$http', '$routeParams', 'teams', 'players',
    ($scope, $http, $routeParams, Team, Player) ->
      $scope.team = Team.get({id: $routeParams.id})
      $scope.players = Player.query()
      $modal = $ '#modal'
      $playerInput = $modal.find('select')

      $scope.toggleModal = ->
        $modal.modal 'toggle'
        return false

      $scope.addPlayer = ->
        $http.put('/api/teams/' + $routeParams.id + '/addPlayer/' + $playerInput.val()).then((response) ->
          $scope.team.players.push(response.data)
          $scope.toggleModal()
        )

      $scope.removePlayer = (playerId, $index) ->
        $http.put('/api/teams/' + $routeParams.id + '/removePlayer/' + playerId).then( ->
          $scope.team.players.splice($index, 1)
        )

  ]