bttendance = angular.module 'bttendance', [
  'ngRoute',
  'ngResource',
  'pascalprecht.translate',
  'templates'
]

bttendance
.factory 'railsLocaleLoader', ($http) ->
  (options) ->
    $http.get('locales/' + options.key + '.json').then (response) ->
      response.data
    , (error) ->
      throw options.key

.config ($provide, $routeProvider, $locationProvider, $translateProvider, $httpProvider, Rails) ->
    $locationProvider.html5Mode true

    $routeProvider
      .when '/',
        templateUrl: 'main.html'
        controller: 'MainController'

    # Assets interceptor
    $provide.factory 'railsAssetsInterceptor', ->
      request: (config) ->
        if assetUrl = Rails.templates[config.url]
          config.url = assetUrl
        config
    $httpProvider.interceptors.push('railsAssetsInterceptor')

    # Translation settings
    $translateProvider.useLoader 'railsLocaleLoader'
    $translateProvider
      .registerAvailableLanguageKeys ['ko', 'en'],
        'en_US': 'en'
        'en-US': 'en'
        'en_us': 'en'
      .determinePreferredLanguage()

    # TODO: I18n switcher & storage

.constant('Constants', {
  API_VERSION: 'v1'
})
