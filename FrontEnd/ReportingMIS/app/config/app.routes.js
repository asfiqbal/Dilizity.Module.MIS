﻿(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .config(config)
        .run(run);

    config.$inject = ['$stateProvider', '$urlRouterProvider','$locationProvider'];
    function config($stateProvider, $urlRouterProvider, $locationProvider) {
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
                    controller: 'navController',
                    controllerAs: 'vm'
                },
                'sidebar@index': {
                    templateUrl: 'views/sidebar.html',
                    controller: 'sidebarController',
                    controllerAs: 'vm'
                },
                "@index": {
                    templateUrl: 'views/welcome.html',
                    //controller: 'sidebarController',
                    //controllerAs: 'vm'
                },
            },
        })
         .state('index.OpenReport', {
             url: '/Report/:reportId/:permissionId',
             templateUrl: 'views/metaReport.html',
             controller: 'metaReportController',
             controllerAs: 'vm'
         })
        .state('index.Role', {
            url: '^/Role',
            templateUrl: 'views/searchRole.html',
            controller: 'searchRoleController',
            controllerAs: 'vm'
        })
        .state('index.ActionRole', {
            url: '^/Role/:roleId/:permissionName',
            templateUrl: 'views/actionRole.html',
            controller: 'actionRoleController',
            controllerAs: 'vm'
        })
        .state('index.Report1', {
             url: '/Report1',
             templateUrl: 'views/report1.html',
             controller: 'reportController',
             controllerAs: 'vm'
        });
        $locationProvider.html5Mode(true);
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