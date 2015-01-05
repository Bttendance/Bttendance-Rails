bttendance = angular.module 'bttendance', [
  'ngRoute',
  'pascalprecht.translate',
  'templates',
  'controllers'
]

bttendance.config ['$routeProvider', '$locationProvider', '$translateProvider',
  ($routeProvider, $locationProvider, $translateProvider) ->
    $locationProvider.html5Mode true

    $routeProvider
      .when '/',
        templateUrl: 'main.html'
        controller: 'MainController'

    $translateProvider.useStaticFilesLoader(
      prefix: '/assets/locales/'
      suffix: '.json'
    )

    $translateProvider.preferredLanguage 'ko'

    # TODO: I18n switcher & storage
]

controllers = angular.module 'controllers', []
