'use strict'

angular.module 'bttendance'
.controller 'DashStartController', ($scope, $modal) ->
  $scope.openAddCourseModal = ->
    $modal.open
      templateUrl: 'modals/add_course.html'
      controller: 'AddCourseModalController'
      windowClass: 'add-course-modal'
