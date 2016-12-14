(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .config(config)
        .run(run);

    config.$inject = ['$stateProvider', '$urlRouterProvider'];
    function config($stateProvider, $urlRouterProvider) {
        //$urlRouterProvider.otherwise('/home');
        $urlRouterProvider.otherwise('/');

        $stateProvider.state('index', {
            url: '/',
            views: {
                '@': {
                    templateUrl: 'views/layout.html',
                    controller: 'layoutController',
                    controllerAs: 'vm'
                },
                'nav@index': {
                    templateUrl: 'views/nav.html',
                    controller: 'menuController',
                    controllerAs: 'vm'
                },
                'sidebar@index': {
                    templateUrl: 'views/sidebar.html',
                    controller: 'sidebarController',
                    controllerAs: 'vm'
                },
            },
        })
         .state('index.OpenReport', {
             url: '/Report/:reportId/:permissionId',
             templateUrl: 'views/metaReport.html',
             controller: 'metaReportController',
             controllerAs: 'vm'
         })
        .state('index.Report1', {
             url: '/Report1',
             templateUrl: 'views/report1.html',
             controller: 'reportController',
             controllerAs: 'vm'
         });



        //.state('index.report1', {
        //    url: '/report1',
        //    views: {
                
        //        'content': {
        //            templateUrl: 'views/report1.html',
        //            controller: 'reportController',
        //            controllerAs: 'vm'
        //        }
        //    }
        //})


        //.state('app.home', {
        //    url: '/home',
        //    templateUrl: 'views/homeView.html',
        //    controller: 'homeController',
        //    controllerAs: 'vm'
        //});

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