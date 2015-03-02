'use strict';

angular.module 'bttendance'
.factory 'User', ($resource, Constants) ->
  $resource('/api/' + Constants.API_VERSION + '/users/:id', {
    id: '@id'
  },
    count:
      params:
        id: 'count'
    me:
      params:
        id: 'me'
    logout:
      method: 'DELETE'
      params:
        id: 'logout'
  )
