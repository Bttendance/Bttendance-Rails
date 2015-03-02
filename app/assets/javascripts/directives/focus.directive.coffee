'use strict'

angular.module 'bttendance'
.directive 'focus', ($parse, $timeout) ->
  {
    link: (scope, element, attrs) ->
      model = $parse attrs.focus
      scope.$watch model, (value) ->
        if value is true
          $timeout ->
            element[0].focus()
            return
        return
  }