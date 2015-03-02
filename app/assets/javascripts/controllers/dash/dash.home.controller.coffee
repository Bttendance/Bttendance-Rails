'use strict'

angular.module 'bttendance'
.controller 'DashHomeController', ($scope, $state) ->
  $scope.$watch 'currentUser.courses', () ->
    console.log 'DashHome CurrentUserCourses: ', arguments
