(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .config(config)
        .run(run);

    config.$inject = ['$stateProvider', '$urlRouterProvider'];
    function config($stateProvider, $urlRouterProvider) {
        $stateProvider

            .state('home', {
                url: '/home',
                templateUrl: 'views/homeView.html',
                controller: 'homeController',
                controllerAs: 'vm'
            })

            .state('home.menu', {
                    views: {
                        'menu': {
                            templateUrl: 'views/nav.html',
                            controller: 'menuController'
                        }
                    }
                })

            .state('report1', {
                url: '/',
                controller: 'reportController',
                templateUrl: 'views/report1.html',
                controllerAs: 'vm'
            })

            .state('report2', {
                url: '/',
                templateUrl: 'views/report2.html'
            })

        $urlRouterProvider.when("", "/home");
    }

    run.$inject = ['$rootScope', '$location', '$state','$cookieStore', '$http'];
    function run($rootScope, $location, $state, $cookieStore, $http) {
        // keep user logged in after page refresh
        $rootScope.globals = $cookieStore.get('globals') || {};
        if ($rootScope.globals.currentUser) {
            $http.defaults.headers.common['Authorization'] = 'Basic ' + $rootScope.globals.currentUser.authdata; // jshint ignore:line
        }

        //$rootScope.$on('$locationChangeStart', function (event, next, current) {
        //    // redirect to login page if not logged in and trying to access a restricted page
        //    var restrictedPage = $.inArray($location.path(), ['/login', '/register']) === -1;
        //    var loggedIn = $rootScope.globals.currentUser;
        //    if (restrictedPage && !loggedIn) {
        //        $location.path('/login');
        //    }
        //});
    }

})();