'use strict';

angular.module 'bttendance'
.factory 'Course', ($resource, Constants) ->
  $resource '/api/' + Constants.API_VERSION + '/courses/:id',
    'query':
      method: 'GET'
      isArray: false
