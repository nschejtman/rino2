rinoApp = angular.module('rinoApp')

rinoApp.controller 'playersController',
  ['$scope', 'players',
    ($scope, Player) ->

#Set player list
      $scope.players = Player.query()

      $modal = $ '#modal'
      $modalTitle = $modal.find('.modal-title')

      $scope.toggleCreate = ->
        $modal.modal 'toggle'
        $modalTitle.html "Nuevo Jugador"
        $scope.nameInput = ""
        $scope.confirmModal = $scope.create
        return false

      $scope.toggleUpdate = (player) ->
        $modal.modal 'toggle'
        $modalTitle.html "Editar jugador"
        $scope.dniInput = player.dni
        $scope.firstNameInput = player.firstName
        $scope.lastNameInput = player.lastName
        $scope.emailInput = player.email
        $scope.telephoneInput = player.phone
        $scope.updatePlayer = player
        $scope.confirmModal = $scope.update

      #Create a player
      $scope.create = () ->
        player = new Player(
          {
            id: null,
            dni: $scope.dniInput,
            firstName: $scope.firstNameInput,
            lastName: $scope.lastNameInput,
            email: $scope.emailInput,
            phone: $scope.telephoneInput
          }
        )
        Player.save player,
          (response) ->
            $scope.players.push(response)
            $modal.modal 'toggle',
              (errors) ->
            $scope.errors = errors

      #Update a player
      $scope.update = () ->
        $scope.updatePlayer.dni = $scope.dniInput
        $scope.updatePlayer.firstName = $scope.firstNameInput
        $scope.updatePlayer.lastName = $scope.lastNameInput
        $scope.updatePlayer.email = $scope.emailInput
        $scope.updatePlayer.phone = $scope.telephoneInput
        Player.update $scope.updatePlayer, () ->
          $modal.modal 'toggle'


      #Delete a player
      $scope.delete = (player, $index) ->
        Player.delete(player, -> $scope.players.splice($index, 1))
  ]