'use strict'

angular.module 'bttendance'
.controller 'SidenavController', ($scope, $filter, $state) ->
  $scope.isState = (stateName) ->
    $filter('isState')(stateName) ? true : false
