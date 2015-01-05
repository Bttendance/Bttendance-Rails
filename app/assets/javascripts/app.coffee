bttendance = angular.module 'bttendance', [
  'ngRoute',
  'templates',
  'controllers'
]

bttendance.config ['$routeProvider', '$locationProvider',
  ($routeProvider, $locationProvider) ->
    $locationProvider.html5Mode true

    $routeProvider
      .when '/',
        templateUrl: 'main.html'
        controller: 'MainController'
]

controllers = angular.module 'controllers', []
