'use strict'

angular.module 'bttendance'
.directive 'errorList', ->
  {
    restrict: 'E'
    template: '<ul class=\'error-list\' ng-show="errors.length > 0">' +
                '<li ng-repeat=\'error in errors\'>{{ error }}</li>' +
              '</ul>'
    replace: true
    scope: false
  }