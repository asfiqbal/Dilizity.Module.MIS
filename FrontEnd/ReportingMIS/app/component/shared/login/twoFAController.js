(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('twoFAController', twoFAController);

    twoFAController.$inject = ['$window', '$location', '$state', 'AuthenticationService', 'Notification'];
    function twoFAController($window, $location, $state, AuthenticationService, Notification) {
        var vm = this;

        vm.validate = validate;

        (function initController() {
            // reset login status
            vm.permission = 'Dilizity.Login.TwoFA';
        })();

        function validate() {
            console.log("validate Begin");

            console.log("vm.permission", vm.permission);
            AuthenticationService.TwoFAValidate(vm.permission, vm.username, vm.password, function (response) {
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
                    Notification.success({ message: "Login Successfull", positionY: 'bottom', positionX: 'right' });
                    $state.go('index');
                }
                else  {
                    Notification.error({ message: data.ErrorMessage, positionY: 'bottom', positionX: 'right' });
                }

            }, function (response) {
                Notification.error({ message: "Internal Server Error Occurred!, Check Server Logs.", positionY: 'bottom', positionX: 'right' });
            });

            console.log("validate End");

        };

    }

})();
