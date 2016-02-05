rinoApp = angular.module('rinoApp')

rinoApp.controller 'teamsController',
  ['$scope', 'teams',
    ($scope, Team) ->

#Set team list
      $scope.teams = Team.query()

      modal = new ModalUI($ '#modal')
      myErrorHandler = new UIErrorHandler($ '#form')

      isUpdate = false

      $scope.confirmModal = ->
        modal.blockConfirmButton()
        if isUpdate
          update()
        else
          create()

      $scope.closeModal = ->
        modal.close()
        modal.unblockConfirmButton()
        myErrorHandler.clearAllErrors()


      $scope.toggleCreate = ->
        modal.show()
        modal.setTitle "Nuevo equipo"
        $scope.nameInput = ""
        isUpdate = false

      $scope.toggleUpdate = (team) ->
        modal.show()
        modal.setTitle "Editar equipo"
        $scope.nameInput = team.name
        $scope.updateTeam = team
        isUpdate = true

      #Create a team
      create = () ->
        team = new Team(
          {
            id: null,
            name: $scope.nameInput,
            players: []
          }
        )
        Team.save team,
          (data) ->
            $scope.teams.push(data)
            modal.close()
            modal.unblockConfirmButton()
            notificationHandler.notifySuccess("Se ha creado el equipo exitosamente")
        ,
          (errorResponse) ->
            if modal.isVisible()
              myErrorHandler.clearAllErrors()
              ErrorResponseHandler.displayInForm(errorResponse, myErrorHandler, modal)
            else
              ErrorResponseHandler.notify(errorResponse, notificationHandler, modal)

      #Update a team
      update = () ->
        $scope.updateTeam.name = $scope.nameInput
        Team.update $scope.updateTeam, () ->
          modal.close()


      #Delete a team
      $scope.delete = (team, $index) ->
        Team.delete(team, -> $scope.teams.splice($index, 1))
  ]