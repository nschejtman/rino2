rinoApp = angular.module('rinoApp')

rinoApp.controller 'tournamentsController',
  ['$scope', 'tournaments', 'categories'
    ($scope, Tournament, Category) ->
      $scope.activeTournaments = Tournament.query({active: 'true'})
      $scope.finishedTournaments = Tournament.query({active: 'false'})
      $scope.categories = Category.query()

      $modal = $ '#modal'
      $modalTitle = $modal.find('.modal-title')
      $categoryInput = $modal.find('#categoryInput')
      tournamentForDelete = null
      indexForDelete = null
      delModal = new ModalUI($ '#confirm-delete-modal')

      $scope.toggleCreate = ->
        $modal.modal 'toggle'
        $modalTitle.html "Nuevo torneo"
        $scope.nameInput = ""
        $scope.confirmModal = $scope.create
        return false

      $scope.toggleUpdate = (tournament) ->
        $modal.modal 'toggle'
        $modalTitle.html "Editar torneo"
        $scope.nameInput = tournament.name
        $categoryInput.val(tournament.category.id)
        $scope.updateTournament = tournament
        $scope.confirmModal = $scope.update

      $scope.update = () ->
        $scope.updateTournament.name = $scope.nameInput
        $scope.updateTournament.category = {
          id: $categoryInput.val(),
          name: $categoryInput.find('option:selected').html()
        }
        Tournament.update $scope.updateTournament, () ->
          $modal.modal 'toggle'

      #Create a tournament
      $scope.create = ->
        tournament = new Tournament({
          id: null,
          name: $scope.nameInput,
          category: {
            id: $categoryInput.val(),
            name: $categoryInput.find('option:selected').html()
          },
          active: true
        })
        Tournament.save tournament,
          (data) ->
            $scope.activeTournaments.push(data)
            $modal.modal 'toggle'
        ,
          (errorResponse) -> errorHandler.handle(errorResponse, $modal)

      #Delete a tournament
      $scope.delete = () ->
        if tournamentForDelete.active
          Tournament.delete(tournamentForDelete, -> $scope.activeTournaments.splice(indexForDelete, 1); delModal.close())
        else
          Tournament.delete(tournamentForDelete, -> $scope.finishedTournaments.splice(indexForDelete, 1); delModal.close())

      #Finish a tournament
      $scope.finishTournament = (tournament, $index) ->
        tournament.active = false
        Tournament.update tournament, ->
          $scope.activeTournaments.splice $index, 1
          $scope.finishedTournaments.push tournament

      #Reactivate a tournament
      $scope.reactivateTournament = (tournament, $index) ->
        tournament.active = true
        Tournament.update tournament, ->
          $scope.finishedTournaments.splice $index, 1
          $scope.activeTournaments.push tournament

      # Delete a category
      $scope.confirmDelete = (tournament, $index) ->
        delModal.show()
        tournamentForDelete = tournament
        indexForDelete = $index

      $scope.dismissDeleteModal = delModal.close
  ]
