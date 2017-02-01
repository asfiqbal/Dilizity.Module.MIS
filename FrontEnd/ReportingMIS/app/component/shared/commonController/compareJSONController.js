(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('compareJSONController', compareJSONController);

    compareJSONController.$inject = ['$location', '$state', 'AuthenticationService', 'Notification','$uibModalInstance'];
    function compareJSONController($location, $state, AuthenticationService, Notification, $uibModalInstance, beautyHtml) {
        var vm = this;

        vm.diffHtml = beautyHtml;

        (function initController() {
        })();

        vm.ok = function () {
            $uibModalInstance.dismiss('cancel');
        };


    }

})();
