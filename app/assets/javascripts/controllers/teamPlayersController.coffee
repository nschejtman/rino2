rinoApp = angular.module('rinoApp')

rinoApp.controller 'teamPlayersController',
  ['$scope', '$http', '$routeParams', 'teams', 'players',
    ($scope, $http, $routeParams, Team, Player) ->
      $scope.team = Team.get({id: $routeParams.id})
      $scope.players = Player.query()
      $modal = $ '#modal' #TODO adapt this to make it use the modal api
      $playerInput = $modal.find('select')

      $scope.toggleModal = ->
        $modal.modal 'toggle'
        return false

      $scope.addPlayer = (player) ->
        $http.put('/api/teams/' + $routeParams.id + '/addPlayer/' + player.id).then((response) ->
          $scope.team.players.push(response.data)
          $scope.toggleModal()
          $scope.searchString = ""
          $scope.showOptions = false
        )

      $scope.removePlayer = (playerId, $index) ->
        $http.put('/api/teams/' + $routeParams.id + '/removePlayer/' + playerId).then( ->
          $scope.team.players.splice($index, 1)
        )


      $scope.playerToAdd = null
      $scope.options = []
      $scope.searchString = ""

      $scope.refreshOptions = () ->
        $http.post('/api/players/search', {'searchString': $scope.searchString}).then(
          (successResponse) ->
            $scope.options = successResponse.data
        )



  ]