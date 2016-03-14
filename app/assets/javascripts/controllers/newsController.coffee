rinoApp = angular.module('rinoApp')

rinoApp.controller 'newsController',
  ['$scope', 'news',
    ($scope, News) ->

# Set news list
      $scope.newsList = News.query()
      modal = new ModalUI($ '#modal')

      myErrorHandler = new UIErrorHandler($ '#form')

      imgInputUrl = null

      imgUploader = new ImgurUploader(document.getElementById('img-input'));


      #Date parse
      $scope.parseDate = (date) ->
        return moment(date).format("DD/MM/YYYY")

      # Used to decide if modal confirmation should be create or update
      isUpdate = false

      #Bind events
      checkDate = ->
        if $scope.dateInput == undefined then $scope.dateInput = new Date()

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
        checkDate()
        modal.show()
        modal.setTitle("Nueva noticia")
        $scope.titleInput = ""
        $scope.bodyInput = ""
        isUpdate = false

      $scope.toggleUpdate = (newsPiece) ->
        modal.show()
        modal.setTitle("Editar noticia")
        $scope.titleInput = newsPiece.title
        $scope.bodyInput = newsPiece.body
        $scope.updateNewsPiece = newsPiece
        isUpdate = true

      #Creates a news piece
      create = () ->
        imgUploader.upload(createCallback)

      #Create a news
      createCallback = (response) ->
        newsPiece = new News(
          {
            id: null
            title: $scope.titleInput
            body: $scope.bodyInput
            "date.time": (if $scope.dateInput != null then ($scope.dateInput.getTime() + 3600000 ) else null)
            imgUrl: response.data.link
          }
        )
        News.save newsPiece,
          (data) ->
            $scope.newsList.push(data)
            modal.close()
            modal.unblockConfirmButton()
            notificationHandler.notifySuccess("Se ha creado la noticia exitosamente")
        ,
          (errorResponse) ->
            if modal.isVisible()
              myErrorHandler.clearAllErrors()
              ErrorResponseHandler.displayInForm(errorResponse, myErrorHandler, modal)
            else
              ErrorResponseHandler.notify(errorResponse, notificationHandler, modal)


      # Update a news
      update = () ->
#        $scope.updateNews.name = $scope.nameInput
        News.update $scope.updateNewsPiece, () ->
          modal.close()
          modal.unblockConfirmButton()


      # Delete a news
      $scope.delete = (newsPiece, $index) ->
        News.delete(newsPiece, -> $scope.newsList.splice($index, 1))

  ]