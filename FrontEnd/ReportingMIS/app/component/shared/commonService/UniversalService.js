(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .factory('UniversalService', UniversalService);

    UniversalService.$inject = ['$http', '$cookieStore', '$rootScope', '$timeout', 'AppSettings'];
    function UniversalService($http, $cookieStore, $rootScope, $timeout, AppSettings) {
        var service = {};

        service.Do = Do;

        return service;

        function Do(permission, username, model, successCallBack, errorCallBack) {
            console.log("UniversalService.Do Begin");

            $http.post(AppSettings.baseUrl + 'Universal/Do', { PermissionId: permission, LoginId: username, Model: model })
                .then(function (response) {
                    successCallBack(response);
                }, function (response) {
                    errorCallBack(response);
                }
            );

            console.log("UniversalService.Do End");
        }

    };

})();