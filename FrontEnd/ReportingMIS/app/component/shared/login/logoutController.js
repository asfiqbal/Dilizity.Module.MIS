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
            // reset login status
            AuthenticationService.ClearCredentials();
        })();

        function logout() {
            console.log("logout Begin");
            $location.path('/login');

            console.log("logout End");

        };
    }

})();
