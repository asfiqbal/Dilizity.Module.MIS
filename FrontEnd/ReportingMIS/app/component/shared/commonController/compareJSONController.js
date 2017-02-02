(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('compareJSONController', compareJSONController);

    compareJSONController.$inject = ['$location', '$state', 'AuthenticationService', 'Notification','$uibModalInstance', 'CommunicationService'];
    function compareJSONController($location, $state, AuthenticationService, Notification, $uibModalInstance, CommunicationService) {
        var vm = this;

        vm.diffHtml = '';

        (function initController() {
            console.log('compareJSONController.initController Begin');

            vm.diffHtml = CommunicationService.Get('COMPARE');
            console.log('diffHtml', vm.diffHtml);
            console.log('compareJSONController.initController End');
        })();

        vm.ok = function () {
            $uibModalInstance.dismiss('cancel');
        };


    }

})();
