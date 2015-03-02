'use strict';

angular.module 'bttendance'
.factory 'Course', ($resource, Constants) ->
  $resource '/api/' + Constants.API_VERSION + '/courses/:id', {
    id: '@id'
  },
    count:
      params:
        id: 'count'
