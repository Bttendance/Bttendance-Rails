'use strict'

angular.module 'bttendance'
.factory 'Auth', ($rootScope, $q, $state, Rails, User, AccessToken) ->
  currentUser = undefined

  Auth =
    AUTH_URL: "//#{Rails.host}/oauth/authorize?response_type=token&client_id=#{Rails.application_id}&redirect_uri=http://#{Rails.host}"
    register: (obj) ->
      deferred = $q.defer()
      User.save(obj).$promise.then ((user) ->
        currentUser = user
        deferred.resolve user
      ), ((err) ->
        deferred.reject err
      )
      deferred.promise

    logout: ->
      deferred = $q.defer()
      User.logout().$promise.then (() ->
        AccessToken.delete()
        Auth.setLoggedIn false
        $state.go 'main'
      ), (() ->
        console.log 'Err: ', arguments
      )
      deferred.promise

    setLoggedIn: (isLoggedIn) ->
      @loggedIn = !!isLoggedIn
      if @loggedIn
        User.me().$promise.then((user) ->
          currentUser = user
          $rootScope.$broadcast 'userLoggedIn', user
        )

    currentUser: ->
      currentUser

  Auth.setLoggedIn AccessToken.get()

  Auth
