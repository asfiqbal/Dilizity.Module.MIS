(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('loginController', loginController);

    loginController.$inject = ['$window', '$location', '$state', 'AuthenticationService', 'FlashService'];
    function loginController($window, $location, $state, AuthenticationService, FlashService) {
        var vm = this;

        vm.login = login;

        (function initController() {
            // reset login status
            vm.permission = 'Dilizity.Login';
            AuthenticationService.ClearCredentials();
        })();

        function login() {
            vm.dataLoading = true;
            console.log("vm.permission", vm.permission);
            AuthenticationService.Login(vm.permission, vm.username, vm.password, function (response) {
                console.log("AuthenticationService.Login", response.ActionCode)
                if (response.status == 200) {
                    AuthenticationService.SetCredentials(vm.username, vm.password);
                    $window.location = '/index.html';
                }
                if (response.status == 206) {
                    console.log("AuthenticationService.Login", response.ActionCode);
                    AuthenticationService.SetCredentials(vm.username, vm.password);
                    $window.location = '/changePassword.html';
                } else {
                    console.log("response.Message", response.Message);
                    FlashService.Error("Login Failed!");
                    vm.dataLoading = false;
                }
            });
        };
    }

})();
