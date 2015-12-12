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
  .when('/tournaments/:id/tables',
    templateUrl: '/admin/tournaments/tables',
    controller: 'tournamentController')
  .when('/teams',
    templateUrl: '/admin/teams',
    controller: 'teamsController')
  .when('/players',
    templateUrl: '/admin/players',
    controller: 'playersController')
  .when('/tournaments/:id/teams',
    templateUrl: '/admin/tournaments/teams',
    controller: 'tournamentTeamsController')
  .when('/teams/:id/players',
    templateUrl: '/admin/teams/players',
    controller: 'teamPlayersController')

# Resources
rinoApp.factory 'categories', ($resource) -> $resource '/api/categories/:id', {id: '@id'}, {update: {method: 'PUT'}}

rinoApp.factory 'tournaments', ($resource) -> $resource '/api/tournaments/:id', {id: '@id'}, {update: {method: 'PUT'}}

rinoApp.factory 'teams', ($resource) -> $resource '/api/teams/:id', {id: '@id'}, {update: {method: 'PUT'}}

rinoApp.factory 'players', ($resource) -> $resource '/api/players/:id', {id: '@id'}, {update: {method: 'PUT'}}


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
        Tournament.save tournament, (data) ->
          $scope.activeTournaments.push(data)
          $modal.modal 'toggle'

      #Delete a tournament
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

      #Reactivate a tournament
      $scope.reactivateTournament = (tournament, $index) ->
        tournament.active = true
        Tournament.update tournament, ->
          $scope.finishedTournaments.splice $index, 1
          $scope.activeTournaments.push tournament
  ]

rinoApp.controller 'tournamentController',
  ['$scope', '$routeParams', 'tournaments', 'categories',
    ($scope, $routeParams, Tournament, Category) ->
      $scope.tournament = Tournament.get({id: $routeParams.id})
      $scope.message = "asd"
      $scope.asdasd = {id: 1, name: 'asdasd'}
  ]

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
            $modal.modal 'toggle',
              (errors) ->
            $scope.errors = errors

      #Update a team
      $scope.update = () ->
        $scope.updateTeam.name = $scope.nameInput
        Team.update $scope.updateTeam, () ->
          $modal.modal 'toggle'


      #Delete a team
      $scope.delete = (team, $index) ->
        Team.delete(team, -> $scope.teams.splice($index, 1))
  ]

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

rinoApp.controller 'tournamentTeamsController',
  ['$scope', '$http', '$routeParams', 'tournaments', 'teams',
    ($scope, $http, $routeParams, Tournament, Team) ->
      $scope.tournament = Tournament.get({id: $routeParams.id})
      $scope.teams = Team.query()
      $modal = $ '#modal'
      $teamInput = $modal.find('select')

      $scope.toggleModal = () ->
        $modal.modal 'toggle'
        return false

      $scope.addTeam = ->
        $http.put('/api/tournaments/' + $routeParams.id + '/addTeam/' + $teamInput.val()).then( ->
          $scope.tournament.teams.push({id: $teamInput.val(), name: $teamInput.find('option:selected').html()})
          $scope.toggleModal()
        )

      $scope.removeTeam = (teamId, $index) ->
        $http.put('/api/tournaments/' + $routeParams.id + '/removeTeam/' + teamId).then( ->
          $scope.tournament.teams.splice($index, 1)
        )
  ]

rinoApp.controller 'teamPlayersController',
  ['$scope', '$http', '$routeParams', 'teams', 'players',
    ($scope, $http, $routeParams, Team, Player) ->
      $scope.team = Team.get({id: $routeParams.id})
      $scope.players = Player.query()
      $modal = $ '#modal'
      $playerInput = $modal.find('select')

      $scope.toggleModal = ->
        $modal.modal 'toggle'
        return false

      $scope.addPlayer = ->
        $http.put('/api/teams/' + $routeParams.id + '/addPlayer/' + $playerInput.val()).then((response) ->
          $scope.team.players.push(response.data)
          $scope.toggleModal()
        )

      $scope.removePlayer = (playerId, $index) ->
        $http.put('/api/teams/' + $routeParams.id + '/removePlayer/' + playerId).then( ->
          $scope.team.players.splice($index, 1)
        )

  ]