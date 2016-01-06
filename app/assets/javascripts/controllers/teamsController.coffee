rinoApp = angular.module('rinoApp')

rinoApp.controller 'teamsController',
  ['$scope', 'teams',
    ($scope, Team) ->

#Set team list
      $scope.teams = Team.query()

      $modal = $ '#modal'
      $modalTitle = $modal.find('.modal-title')

      $scope.toggleCreate = ->
        $modal.modal 'toggle'
        $modalTitle.html "Nuevo equipo"
        $scope.nameInput = ""
        $scope.confirmModal = $scope.create
        return false

      $scope.toggleUpdate = (team) ->
        $modal.modal 'toggle'
        $modalTitle.html "Editar equipo"
        $scope.nameInput = team.name
        $scope.updateTeam = team
        $scope.confirmModal = $scope.update

      #Create a team
      $scope.create = () ->
        team = new Team(
          {
            id: null,
            name: $scope.nameInput,
            players: []
          }
        )
        Team.save team,
          (response) ->
            $scope.teams.push(response)
            $modal.modal 'toggle'
        ,
          (errorResponse) ->
            errorHandler.handle(errorResponse, $modal)

      #Update a team
      $scope.update = () ->
        $scope.updateTeam.name = $scope.nameInput
        Team.update $scope.updateTeam, () ->
          $modal.modal 'toggle'


      #Delete a team
      $scope.delete = (team, $index) ->
        Team.delete(team, -> $scope.teams.splice($index, 1))
  ]