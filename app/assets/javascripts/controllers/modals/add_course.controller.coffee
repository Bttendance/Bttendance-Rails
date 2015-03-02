'use strict'

angular.module 'bttendance'
.controller 'AddCourseModalController', ($scope, $modalInstance, $translate) ->
  $scope.step = 'choose-path'

  $scope.dismiss = ->
    $modalInstance.dismiss()

  $scope.registerCourse = ->
    $translate('modals.add_course.register_course').then (str) ->
      $scope.title = str
      $scope.step = 'register-course'

  $scope.joinCourse = ->
    $translate('modals.add_course.class_code').then (str) ->
      $scope.title = str
      $scope.step = 'join-course'
