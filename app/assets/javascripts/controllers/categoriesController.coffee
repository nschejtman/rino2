rinoApp = angular.module('rinoApp')

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
        category = new Category(
          {
            id: null,
            name: $scope.nameInput,
            tournaments: []
          }
        )
        Category.save category,
          (data) ->
            $scope.categories.push(data)
            $modal.modal 'toggle'
        ,
          (errorResponse) ->
            $modal.modal 'toggle'
            $.each(errorResponse.data, (field, errors) ->
              $.each(errors, (index, error)->
                $.notify({
                 message: field + ":" + error
                }, {
                  type: 'danger',
                  animate: {
                    enter: 'animated fadeInDown',
                    exit: 'animated fadeOutUp'
                  }
                })
              )
            )

      #Update a category
      $scope.update = () ->
        $scope.updateCategory.name = $scope.nameInput
        Category.update $scope.updateCategory, () ->
          $modal.modal 'toggle'


      #Delete a category
      $scope.delete = (category, $index) ->
        Category.delete(category, -> $scope.categories.splice($index, 1))


  ]
