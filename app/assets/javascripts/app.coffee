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
    controller: 'tournamentTablesController')
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
  .when('/tournaments/:id/fixture'
    templateUrl: '/admin/tournaments/fixtures',
    controller: 'tournamentFixturesController')

# Resources
rinoApp.factory 'categories', ($resource) -> $resource '/api/categories/:id', {id: '@id'}, {update: {method: 'PUT'}}

rinoApp.factory 'tournaments', ($resource) -> $resource '/api/tournaments/:id', {id: '@id'}, {update: {method: 'PUT'}}

rinoApp.factory 'teams', ($resource) -> $resource '/api/teams/:id', {id: '@id'}, {update: {method: 'PUT'}}

rinoApp.factory 'players', ($resource) -> $resource '/api/players/:id', {id: '@id'}, {update: {method: 'PUT'}}