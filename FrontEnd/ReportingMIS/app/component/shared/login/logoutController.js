(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('logoutController', logoutController);

    logoutController.$inject = ['$window', '$location', '$state', 'AuthenticationService', 'Notification'];
    function logoutController($window, $location, $state, AuthenticationService, Notification) {
        var vm = this;

        vm.logout = logout;

        (function initController() {
            console.log("logout Begin");
            AuthenticationService.ClearCredentials();
            logout();
            console.log("logout End");
        })();

        function logout() {
            console.log("logout Begin");
            //$location.path('/login');
            $location.path('/login');
            console.log("logout End");
        };
    }

})();
