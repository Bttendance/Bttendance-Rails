'use strict'

angular.module 'bttendance'
.controller 'NavbarController', ($rootScope, $scope, $modal, Auth) ->
  $rootScope.$on 'userLoggedIn', (evt, user) ->
    $scope.currentUser = user

  $scope.openAddCourseModal = ->
    $modal.open
      templateUrl: 'modals/add_course.html'
      controller: 'AddCourseModalController'
      windowClass: 'add-course-modal'
