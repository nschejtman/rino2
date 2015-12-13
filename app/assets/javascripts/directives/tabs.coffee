angular.module('rinoApp').directive('tabs', ->
  {
    restrict: 'E'
    transclude: true
    scope: {}
    controller: [
      '$scope'
      ($scope) ->
        panes = $scope.panes = []

        $scope.select = (pane) ->
          angular.forEach panes, (pane) ->
            pane.selected = false
            return
          pane.selected = true
          return

        @addPane = (pane) ->
          if panes.length == 0
            $scope.select pane
          panes.push pane
          return

        return
    ]
    template: '<div class="tabbable">' + '<ul class="nav nav-tabs">' + '<li ng-repeat="pane in panes" ng-class="{active:pane.selected}">' + '<a href="" ng-click="select(pane)">{{pane.title}}</a>' + '</li>' + '</ul>' + '<div class="tab-content" ng-transclude></div>' + '</div>'
    replace: true
  }
).directive 'pane', ->
  {
    require: '^tabs'
    restrict: 'E'
    transclude: true
    scope: title: '@'
    link: (scope, element, attrs, tabsCtrl) ->
      tabsCtrl.addPane scope
      return
    template: '<div class="tab-pane" ng-class="{active: selected}" ng-transclude>' + '</div>'
    replace: true
  }