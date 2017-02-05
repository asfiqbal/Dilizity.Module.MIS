(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('loginController', loginController);

    loginController.$inject = ['$window', '$location', '$state', 'AuthenticationService', 'Notification'];
    function loginController($window, $location, $state, AuthenticationService, Notification) {
        var vm = this;

        vm.login = login;

        (function initController() {
            // reset login status
            vm.permission = 'Dilizity.Login';
            AuthenticationService.ClearCredentials();
        })();

        function login() {
            console.log("Login Begin");

            vm.dataLoading = true;
            console.log("vm.permission", vm.permission);
            AuthenticationService.Login(vm.permission, vm.username, vm.password, function (response) {
                console.log("Success!");

                var data = angular.fromJson(response.data);
                if (data.ErrorCode == 0) {
                    AuthenticationService.SetCredentials(vm.username, vm.password);
                    if (data.ActionCode <= 0) {
                        Notification.success({ message: "Login Successfull", positionY: 'bottom', positionX: 'right' });
                        $window.location = '/index.html';
                    }
                    else {
                        console.log("ActionCode", data.ActionCode);
                        $location.path('/changePassword');
                    }
                }
                else  {
                    Notification.error({ message: data.ErrorMessage, positionY: 'bottom', positionX: 'right' });
                }

            }, function (response) {
                Notification.error({ message: "Internal Server Error Occurred!, Check Server Logs.", positionY: 'bottom', positionX: 'right' });
            });
            vm.dataLoading = false;
            console.log("Login End");

        };
    }

})();
