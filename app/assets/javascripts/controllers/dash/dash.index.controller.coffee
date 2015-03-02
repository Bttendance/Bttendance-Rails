'use strict'

angular.module 'bttendance'
.controller 'DashIndexController', ($rootScope, $scope, $state, Auth) ->
  $rootScope.$on 'userLoggedIn', (evt, user) ->
    $scope.currentUser = user
    if not user.courses or user.courses.length < 1
      $state.go 'dash.start'

  $scope.logout = ->
    Auth.logout()
