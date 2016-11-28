(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('homeController', homeController);

    homeController.$inject = ['UserService', '$rootScope'];
    function homeController(UserService, $rootScope) {
        var vm = this;

        vm.user = null;

        initController();

        function initController() {
            loadCurrentUser();
        }

        function loadCurrentUser() {
            vm.user = UserService.GetByUsername($rootScope.globals.currentUser.username);
        }


    }

})();