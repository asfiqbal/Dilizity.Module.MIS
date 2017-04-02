(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('twoFAController', twoFAController);

    twoFAController.$inject = ['$window', '$location', '$state', '$stateParams', 'AuthenticationService', 'Notification', 'CommunicationService'];
    function twoFAController($window, $location, $state, $stateParams, AuthenticationService, Notification, CommunicationService) {
        var vm = this;

        vm.permission = '';
        vm.code = '';
        vm.userId = '';
        vm.validate = validate;
        vm.generate = generate;

        (function initController() {
            // reset login status
            console.log("stateParams.permissionId", $stateParams.permissionId);
            console.log("stateParams.userId", $stateParams.userId);
            vm.permission = $stateParams.permissionId;
            vm.userId = $stateParams.userId;
        })();

        function validate() {
            console.log("validate Begin");

            var permissionId = vm.permission + '.TwoFA';

            console.log("permissionId", permissionId);
            //var userName = CommunicationService.Get("LOGIN_ID");
            console.log("vm.userId", vm.userId);

            AuthenticationService.TwoFAValidate(permissionId, vm.userId, vm.code, function (response) {
                console.log("Success!");

                var data = angular.fromJson(response.data);
                if (data.ErrorCode == 0) {
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

        function generate() {
            console.log("generate Begin");

            var permissionId = vm.permission + '.Generate2FAToken';
            console.log("permissionId", permissionId);
            //var userName = CommunicationService.Get("LOGIN_ID");
            console.log("vm.userId", vm.userId);

            AuthenticationService.Generate(permissionId, vm.userId, function (response) {
                console.log("Success!");

                var data = angular.fromJson(response.data);
                if (data.ErrorCode == 0) {
                    Notification.success({ message: data.ErrorMessage, positionY: 'bottom', positionX: 'right' });
                }
                else {
                    Notification.error({ message: data.ErrorMessage, positionY: 'bottom', positionX: 'right' });
                }
            }, function (response) {
                Notification.error({ message: "Internal Server Error Occurred!, Check Server Logs.", positionY: 'bottom', positionX: 'right' });
            });

            console.log("generate End");

        };

    }

})();
