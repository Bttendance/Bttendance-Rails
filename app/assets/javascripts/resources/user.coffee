'use strict';

angular.module 'bttendance'
.factory 'User', ($resource, Constants) ->
  $resource '/api/' + Constants.API_VERSION + '/users/:id',
    query:
      method: 'GET'
      isArray: false
