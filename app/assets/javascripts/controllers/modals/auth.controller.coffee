'use strict'

angular.module 'bttendance'
.controller 'AuthModalController', ($scope, $location, $modalInstance, Auth, User, AccessToken, Rails) ->
  $scope.dismiss = ->
    $modalInstance.dismiss()

  $scope.authFacebook = ->
    debugger

  $scope.authGoogle = ->
    debugger

  $scope.showEmailForm = ->
    this.$parent.loginFormOpen = false
    this.$parent.emailFormOpen = true
    this.$parent.errors = []

  $scope.showLoginForm = ->
    this.$parent.emailFormOpen = false
    this.$parent.loginFormOpen = true
    this.$parent.errors = []

  $scope.register = (form) ->
    this.errors = []

    obj =
      user:
        name: form.name.$viewValue
        email: form.email.$viewValue
        password: form.password.$viewValue
        devices_attributes: [{ platform: 'Browser' }]

    Auth.register(obj).then (->
      $modalInstance.dismiss()
      $location.path '/dash'
    ), (err) ->
      $scope.errors = $scope.errors.concat err.data.message

  $scope.login = (form) ->
    this.errors = []

    obj =
      email: form.email.$viewValue
      password: form.password.$viewValue
      devices_attributes: { platform: 'Browser' }

    Auth.login(obj).then (->
      $modalInstance.dismiss()
      $location.path '/dash'
    ), (err) ->
      $scope.errors = $scope.errors.concat err.data.message
