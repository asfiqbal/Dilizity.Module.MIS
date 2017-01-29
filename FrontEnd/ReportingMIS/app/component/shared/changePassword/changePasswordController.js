(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('changePasswordController', changePasswordController);

    changePasswordController.$inject = ['$rootScope', '$window', '$location', '$state', 'AuthenticationService', 'Notification'];
    function changePasswordController($rootScope, $window, $location, $state, AuthenticationService, Notification) {
        var vm = this;

        vm.changePassword = changePassword;

        (function initController() {
            // reset login status
            vm.permission = 'Dilizity.ChangePassword';
        })();

        function changePassword() {
            vm.dataLoading = true;
            var username = $rootScope.globals.currentUser.username;
            console.log("vm.permission", vm.permission);
            AuthenticationService.ChangePassword(vm.permission, username, vm.oldPassword, vm.newPassword, function (response) {
                console.log("Success!");

                var data = angular.fromJson(response.data);
                if (data.ErrorCode == 0) {
                    AuthenticationService.SetCredentials(vm.username, vm.password);
                    $window.location = '/index.html';
                }
                else  {
                    Notification.error({ message: data.ErrorMessage, positionY: 'bottom', positionX: 'right' });
                }

            }, function (response) {
                Notification.error({ message: "Internal Server Error Occurred!, Check Server Logs.", positionY: 'bottom', positionX: 'right' });
            });

            vm.dataLoading = false;
        };
    }

})();
