(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .factory('AlertService', AlertService);

    AlertService.$inject = ['$rootScope'];
    function AlertService($rootScope) {
        var AlertService;
        $rootScope.alerts = [];
        return AlertService = {
            Add: function(type, msg) {
                return $rootScope.alerts.push({
                    type: type,
                    msg: msg,
                    Close: function () {
                        return AlertService.CloseAlert(this);
                    }
                });
            },
            CloseAlert: function(alert) {
                return this.CloseAlertIdx($rootScope.alerts.indexOf(alert));
            },
            CloseAlertIdx: function(index) {
                return $rootScope.alerts.splice(index, 1);
            },
            Clear: function(){
                $rootScope.alerts = [];
            }
        };
    };
})();