# Create the module
rinoApp = angular.module('rinoApp', ['ngRoute', 'ngResource'])

# Configure routes
rinoApp.config ($routeProvider) ->
  $routeProvider
  .when('/admin',
    templateUrl: '/admin'
    controller: 'mainController')
  .when '/categories',
    templateUrl: '/admin/categories'
    controller: 'categoriesController'

# Resources
rinoApp.factory 'categories', ($resource) -> $resource '/api/categories/:id', {id: '@id'}, {update: {method: 'PUT'}}


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
