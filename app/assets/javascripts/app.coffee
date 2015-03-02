bttendance = angular.module 'bttendance', [
  'ngResource',
  'ngStorage',
  'pascalprecht.translate',
  'templates',
  'ui.bootstrap',
  'ui.router'
]

bttendance
.factory 'railsLocaleLoader', ($http) ->
  (options) ->
    $http.get('locales/' + options.key + '.json').then (response) ->
      response.data
    , (error) ->
      throw options.key

.config ($provide, $stateProvider, $urlRouterProvider, $locationProvider, $translateProvider, $httpProvider, Rails) ->
    # Assets interceptor
    $provide.factory 'railsAssetsInterceptor', ->
      request: (config) ->
        if assetUrl = Rails.templates[config.url]
          config.url = assetUrl
        config

    # Access Token interceptor
    $provide.factory 'tokenInterceptor', (AccessToken) ->
      request: (config) ->
        if config.url.indexOf('/api/') == 0
          token = AccessToken.get()
          config.headers['Authorization'] = "Bearer #{token}" if token
        config

    # 401 Unauthorized interceptor
    $provide.factory 'unauthorizedInterceptor', ($q, $injector) ->
      responseError: (rejection) ->
        if rejection.status is 401
          $injector.get('AccessToken').delete()
          $injector.get('$state').go 'main'
        $q.reject rejection

    $httpProvider.interceptors.push(
      'railsAssetsInterceptor', 'tokenInterceptor', 'unauthorizedInterceptor'
    )

    $locationProvider.html5Mode true

    # Translation settings
    $translateProvider.useLoader 'railsLocaleLoader'
    $translateProvider
      .registerAvailableLanguageKeys ['ko', 'en'],
        'en_US': 'en'
        'en-US': 'en'
        'en_us': 'en'
      .determinePreferredLanguage()

    # TODO: I18n switcher & storage

.run ($rootScope, $timeout, $state, $location, $stateParams, Auth) ->
  authlessRoutes = ['/', '/users/sign_in']

  $rootScope.$on '$stateChangeStart', (evt, toState) ->
    # Proceed to the dashboard if on main and logged in
    if toState.name is 'main' and Auth.loggedIn
      $timeout(->
        $state.go 'dash.home'
      )

    # Go to login if on auth route and not logged in
    if _.indexOf(authlessRoutes, toState.url) == -1 and !Auth.loggedIn
      $location.path '/login'

.constant 'Constants',
  API_VERSION: 'v1'
  AUTH_URL: '//#{Rails.host}/oauth/authorize?response_type=token&client_id=#{Rails.application_id}&redirect_uri=http://#{Rails.host}'
