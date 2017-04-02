(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('loginController', loginController);

    loginController.$inject = ['$window', '$location', '$state', 'AuthenticationService', 'Notification','CommunicationService'];
    function loginController($window, $location, $state, AuthenticationService, Notification, CommunicationService) {
        var vm = this;

        vm.login = login;

        (function initController() {
            // reset login status
            vm.permission = 'Dilizity.Login';
            vm.dataLoading = false;
            AuthenticationService.ClearCredentials();
            //getSecurityToken();
        })();

        function login() {
            console.log("Login Begin");

            vm.dataLoading = true;
            console.log("vm.permission", vm.permission);
            AuthenticationService.Login(vm.permission, vm.username, vm.password, function (response) {
                console.log("Success!");

                var data = angular.fromJson(response.data);
                if (data.ErrorCode == 0) {
                    var token = data.Data;
                    console.log("token", token);

                    if (!token) {
                        Notification.error({ message: 'Invalid Token Received!', positionY: 'bottom', positionX: 'right' });
                        return;
                    }

                    AuthenticationService.SetCredentials(vm.username, token);
                    if (data.ActionCode <= 0) {
                        Notification.success({ message: "Login Successfull", positionY: 'bottom', positionX: 'right' });
                        $state.go('index');
                    }
                    else if (data.ActionCode == 1) {
                        console.log("ActionCode", data.ActionCode);
                        $state.go('changePassword');
                    }
                    else if (data.ActionCode == 2) {
                        console.log("ActionCode", data.ActionCode);
                        CommunicationService.Set("LOGIN_ID", vm.username);
                        $state.go('twoFA', { userId: vm.username, permissionId: vm.permission });
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

        //function getSecurityToken() {
        //    console.log("getSecurityToken Begin");

        //    AuthenticationService.GetSecurityToken(function (response) {
        //        console.log("Success!");
        //    }, function (response) {
        //        Notification.error({ message: "Internal Server Error Occurred!, Check Server Logs.", positionY: 'bottom', positionX: 'right' });
        //    });
        //    console.log("getSecurityToken End");

        //};

    }

})();
