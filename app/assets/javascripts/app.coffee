# Create the module
rinoApp = angular.module('rinoApp', ['ngRoute', 'ngResource'])

# Configure routes
rinoApp.config ($routeProvider) ->
  $routeProvider
  .when('/admin',
    templateUrl: '/admin'
    controller: 'mainController')
  .when('/categories',
    templateUrl: '/admin/categories'
    controller: 'categoriesController')
  .when('/tournaments',
    templateUrl: '/admin/tournaments'
    controller: 'tournamentsController')

# Resources
rinoApp.factory 'categories', ($resource) -> $resource '/api/categories/:id', {id: '@id'}, {update: {method: 'PUT'}}

rinoApp.factory 'tournaments', ($resource) -> $resource '/api/tournaments/:id', {id: '@id'}, {update: {method: 'PUT'}}


# Create controllers and inject Angular's $scope
rinoApp.controller 'mainController', ($scope) ->
  $scope.message = 'nico rocks'

rinoApp.controller 'categoriesController',
  ['$scope', 'categories',
    ($scope, Category) ->

#Set category list
      $scope.categories = Category.query()

      $modal = $ '#modal'
      $modalTitle = $modal.find('.modal-title')

      $scope.toggleCreate = ->
        $modal.modal 'toggle'
        $modalTitle.html "Nueva categoría"
        $scope.nameInput = ""
        $scope.confirmModal = $scope.create
        return false


      $scope.toggleUpdate = (category) ->
        $modal.modal 'toggle'
        $modalTitle.html "Editar categoría"
        $scope.nameInput = category.name
        $scope.updateCategory = category
        $scope.confirmModal = $scope.update

      #Create a category
      $scope.create = () ->
        category = new Category({id: null, name: $scope.nameInput})
        Category.save category, (data) ->
          $scope.categories.push(data)
          $modal.modal 'toggle'

      #Update a category
      $scope.update = () ->
        $scope.updateCategory.name = $scope.nameInput
        Category.update $scope.updateCategory, () ->
          $modal.modal 'toggle'


      #Delete a category
      $scope.delete = (category, $index) ->
        Category.delete(category, -> $scope.categories.splice($index, 1))


  ]

rinoApp.controller 'tournamentsController',
  ['$scope', 'tournaments', 'categories'
    ($scope, Tournament, Category) ->
      $scope.activeTournaments = Tournament.query({active: 'true'})
      $scope.finishedTournaments = Tournament.query({active: 'false'})
      $scope.categories = Category.query()

      $modal = $ '#modal'
      $modalTitle = $modal.find('.modal-title')
      $categoryInput = $modal.find('#categoryInput')

      $scope.toggleCreate = ->
        $modal.modal 'toggle'
        $modalTitle.html "Nuevo torneo"
        $scope.nameInput = ""
        $scope.confirmModal = $scope.create
        return false

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
        Tournament.save tournament, (data) ->
          $scope.activeTournaments.push(data)
          $modal.modal 'toggle'

      #Delete an active tournament
      $scope.delete = (tournament, $index, active) ->
        if active
          Tournament.delete(tournament, -> $scope.activeTournaments.splice($index, 1))
        else
          Tournament.delete(tournament, -> $scope.finishedTournaments.splice($index, 1))

      #Finish a tournament
      $scope.finishTournament = (tournament, $index) ->
        tournament.active = false
        Tournament.update tournament, ->
          $scope.activeTournaments.splice $index, 1
          $scope.finishedTournaments.push tournament

      $scope.reactivateTournament = (tournament, $index) ->
        tournament.active = true
        Tournament.update tournament, ->
          $scope.finishedTournaments.splice $index, 1
          $scope.activeTournaments.push tournament
  ]
