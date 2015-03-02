'use strict'

angular.module 'bttendance'
.controller 'MainController', ($scope, Course, User, Rails, Auth) ->
  $scope.loginUrl = Auth.AUTH_URL
  $scope.translationData = {}

  Course.count().$promise.then (data) ->
    $scope.translationData.numUniqueCourses = data.course_count

  User.count().$promise.then (data) ->
    $scope.translationData.numUniqueUsers = data.user_count
