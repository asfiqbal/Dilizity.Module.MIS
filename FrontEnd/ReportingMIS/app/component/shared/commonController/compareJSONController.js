(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('compareJSONController', compareJSONController);

    compareJSONController.$inject = ['$location', '$state', 'AuthenticationService', 'Notification','$uibModalInstance', 'CommunicationService'];
    function compareJSONController($location, $state, AuthenticationService, Notification, $uibModalInstance, CommunicationService) {
        var vm = this;

        vm.diffHtml = CommunicationService.Get('COMPARE');

        (function initController() {
        })();

        vm.ok = function () {
            $uibModalInstance.dismiss('cancel');
        };


    }

})();
