(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('changePasswordController', changePasswordController);

    changePasswordController.$inject = ['$rootScope', '$window', '$location', '$state', 'AuthenticationService', 'FlashService'];
    function changePasswordController($rootScope, $window, $location, $state, AuthenticationService, FlashService) {
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
                if (response.status == 200) {
                    console.log("AuthenticationService.ChangePassword", response.Message);
                    $window.location = '/index.html';
                }
                else {
                    console.log("response.Message", response.Message);
                    FlashService.Error("Change Password Failed!");
                    vm.dataLoading = false;
                }
            });
        };
    }

})();
