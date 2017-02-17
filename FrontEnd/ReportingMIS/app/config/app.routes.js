(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .config(config)
        .run(run);

    config.$inject = ['$stateProvider', '$urlRouterProvider', '$locationProvider'];
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
                    templateUrl: 'app/component/shared/sidebar/sidebar.html',
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
            url: '^/Role/:permissionId',
            templateUrl: 'app/component/role/searchRole.html',
            controller: 'searchRoleController',
            controllerAs: 'vm'
        })
        .state('index.Maker', {
            url: '^/Maker/:permissionId',
            templateUrl: 'app/component/maker/maker.html',
            controller: 'makerController',
            controllerAs: 'vm'
        })
        .state('index.Checker', {
            url: '^/Checker/:permissionId',
            templateUrl: 'app/component/checker/checker.html',
            controller: 'checkerController',
            controllerAs: 'vm'
        })
        .state('index.ActionRole', {
            url: '^/Role/:roleId/:makerId/:permissionName',
            templateUrl: 'app/component/role/actionRole.html',
            controller: 'actionRoleController',
            controllerAs: 'vm'
        })
        .state('login', {
            url: '^/login',
            templateUrl: 'app/component/shared/login/login.html',
            controller: 'loginController',
            controllerAs: 'vm'
        })
        .state('changePassword', {
            url: '^/changePassword',
            templateUrl: 'app/component/shared/changePassword/changePassword.html',
            controller: 'changePasswordController',
            controllerAs: 'vm'
        })
        .state('logout', {
            url: '^/logout',
            templateUrl: '',
            controller: 'logoutController',
            controllerAs: 'vm'
        })
        .state('index.Report1', {
             url: '/Report1',
             templateUrl: 'views/report1.html',
             controller: 'reportController',
             controllerAs: 'vm'
        });
        $locationProvider.html5Mode(true).hashPrefix('!');
    }

    run.$inject = ['$rootScope', '$location', '$state', '$cookieStore', '$http', '$window'];
    function run($rootScope, $location, $state, $cookieStore, $http, $window) {
        // keep user logged in after page refresh
        $rootScope.globals = $cookieStore.get('globals') || {};
        if ($rootScope.globals.currentUser) {
            $http.defaults.headers.common['Authorization'] = 'Dilizity ' + $rootScope.globals.currentUser.authdata; // jshint ignore:line
        }

        $rootScope.$on('$locationChangeStart', function (event, next, current) {
            // redirect to login page if not logged in and trying to access a restricted page
            var restrictedPage = $.inArray($location.path(), ['/login', '/register']) === -1;
            var loggedIn = $rootScope.globals.currentUser.username;
            console.log("loggedIn", loggedIn);
            if (restrictedPage && !loggedIn) {
                //$location.path('/login');
                $state.go('login');
            }
        });
    }

})();