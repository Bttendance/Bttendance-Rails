'use strict'

angular.module 'bttendance'
.controller 'MainController', ($scope, Course, User) ->
  $scope.translationData = {}

  Course.query count: true, (data) ->
    $scope.translationData.numUniqueCourses = _.first(data).course_count

  User.query count: true, (data) ->
    $scope.translationData.numUniqueUsers = _.first(data).user_count
