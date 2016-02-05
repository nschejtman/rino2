rinoApp = angular.module('rinoApp')

rinoApp.controller 'playersController',
  ['$scope', 'players',
    ($scope, Player) ->

#Set player list
      $scope.players = Player.query()

      #Set ui handlers
      modal = new ModalUI($ '#modal')
      myErrorHandler = new UIErrorHandler($ '#form')

      # Used to decide if modal confirmation should be create or update
      isUpdate = false

      $scope.confirmModal = () ->
        modal.blockConfirmButton()
        if isUpdate
          update()
        else
          create()

      $scope.closeModal = () ->
        modal.close()
        modal.unblockConfirmButton()
        myErrorHandler.clearAllErrors()

      $scope.toggleCreate = ->
        modal.show()
        modal.setTitle("Nuevo jugador")
        $scope.nameInput = ""
        isUpdate = false

      $scope.toggleUpdate = (player) ->
        modal.show()
        modal.setTitle("Editar jugador")
        $scope.dniInput = player.dni
        $scope.firstNameInput = player.firstName
        $scope.lastNameInput = player.lastName
        $scope.emailInput = player.email
        $scope.telephoneInput = player.phone
        $scope.updatePlayer = player
        isUpdate = true

      #Create a player
      create = () ->
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
            modal.close()
            modal.unblockConfirmButton()
            notificationHandler.notifySuccess("Se ha creado el jugador correctamente")
        ,
          (errorResponse) ->
            if modal.isVisible()
              myErrorHandler.clearAllErrors()
              ErrorResponseHandler.displayInForm(errorResponse, myErrorHandler, modal)
            else
              ErrorResponseHandler.notify(errorResponse, notificationHandler, modal)

      #Update a player
      update = () ->
        $scope.updatePlayer.dni = $scope.dniInput
        $scope.updatePlayer.firstName = $scope.firstNameInput
        $scope.updatePlayer.lastName = $scope.lastNameInput
        $scope.updatePlayer.email = $scope.emailInput
        $scope.updatePlayer.phone = $scope.telephoneInput
        Player.update $scope.updatePlayer, () ->
          modal.close()
          modal.unblockConfirmButton()


      #Delete a player
      $scope.delete = (player, $index) ->
        Player.delete(player, -> $scope.players.splice($index, 1))
  ]