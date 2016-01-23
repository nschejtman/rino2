rinoApp = angular.module('rinoApp')

rinoApp.controller 'categoriesController',
  ['$scope', 'categories',
    ($scope, Category) ->

      # Set category list
      $scope.categories = Category.query()
      $scope.category = {}
      modal = new ModalUI($ '#modal')
      myErrorHandler = new UIErrorHandler($ '#form')

      # Used to decide if modal confirmation should be create or update
      isUpdate = false

      # Action performed when the modal confirmation button is clicked
      $scope.confirmModal = () ->
        modal.blockConfirmButton()
        if isUpdate
          update()
        else
          create()

      # Action performed when the close modal button is clicked
      $scope.closeModal = ->
        modal.close()
        modal.unblockConfirmButton()
        myErrorHandler.clearAllErrors()


      $scope.toggleCreate = ->
        modal.show()
        modal.setTitle("Nueva categoría")
        $scope.nameInput = ""
        isUpdate = false

      $scope.toggleUpdate = (category) ->
        modal.show()
        modal.setTitle("Editar categoría")

        $scope.nameInput = category.name
        $scope.updateCategory = category
        isUpdate = true

      #Create a category
      create = () ->
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
            modal.close()
            modal.unblockConfirmButton()
            notificationHandler.notifySuccess("Se ha creado la categoría exitosamente")
        ,
          (errorResponse) ->
            if modal.isVisible()
              ErrorResponseHandler.displayInForm(errorResponse, myErrorHandler, modal)
            else
              ErrorResponseHandler.notify(errorResponse, notificationHandler, modal)



      # Update a category
      update = () ->
        $scope.updateCategory.name = $scope.nameInput
        Category.update $scope.updateCategory, () ->
          modal.close()
          modal.unblockConfirmButton()


      # Delete a category
      $scope.delete = (category, $index) ->
        Category.delete(category, -> $scope.categories.splice($index, 1))


  ]
