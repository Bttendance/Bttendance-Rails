'use strict'

angular.module 'bttendance'
.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider
    .state('main',
      url: '/'
      templateUrl: 'main.html'
      controller: 'MainController'
    )
    .state('dash',
      url: '/dash'
      abstract: true
      templateUrl: 'dash/index.html'
      controller: 'DashIndexController'
    )
    .state('dash.start',
      url: '/start'
      templateUrl: 'dash/start.html'
      controller: 'DashStartController'
    )
    .state('dash.home',
      url: '/home'
      templateUrl: 'dash/home.html'
      controller: 'DashHomeController'
    )
    .state('dash.attendance',
      url: '/attendance'
      templateUrl: 'dash/attendance.html'
    )
    .state('dash.clicker',
      url: '/clicker'
      templateUrl: 'dash/clicker.html'
    )
    .state('dash.notice',
      url: '/notice'
      templateUrl: 'dash/notice.html'
    )
    .state('dash.curious',
      url: '/curious'
      templateUrl: 'dash/curious.html'
    )
    .state('dash.student',
      url: '/student'
      templateUrl: 'dash/student.html'
    )
    .state('dash.settings',
      url: '/settings'
      templateUrl: 'dash/settings.html'
    )
    .state('accessToken',
      url: '/access_token=:response'
      controller: ($state, $stateParams, AccessToken, Auth) ->
        token = $stateParams.response.match(/^(.*?)&/)[1]
        AccessToken.set token
        Auth.setLoggedIn true
        $state.go 'dash.home'
    )
    .state('401',
      url: '/unauthorized'
      templateUrl: '401.html'
      controller: ($state, AccessToken) ->
        $state.go 'main' if AccessToken.get()
    )

  $urlRouterProvider.otherwise '/'
