bttendance = angular.module 'bttendance', [
  'ngRoute',
  'ngResource',
  'pascalprecht.translate',
  'templates'
]

bttendance.config(['$routeProvider', '$locationProvider', '$translateProvider',
  ($routeProvider, $locationProvider, $translateProvider, $window) ->
    $locationProvider.html5Mode true

    $routeProvider
      .when '/',
        templateUrl: 'main.html'
        controller: 'MainController'

    $translateProvider.useStaticFilesLoader(
      prefix: '/assets/locales/'
      suffix: '.json'
    )

    $translateProvider
      .registerAvailableLanguageKeys ['ko', 'en'],
        'en_US': 'en'
        'en-US': 'en'
        'en_us': 'en'
      .determinePreferredLanguage()

    # TODO: I18n switcher & storage
])
.constant('Constants', {
  API_VERSION: 'v1'
})
