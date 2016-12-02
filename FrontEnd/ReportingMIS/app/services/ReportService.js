(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .factory('ReportService', ReportService);

    ReportService.$inject = ['$http', '$cookieStore', '$rootScope', '$timeout', 'UserService', 'AppSettings'];
    function ReportService($http, $cookieStore, $rootScope, $timeout, UserService, AppSettings) {
        var service = {};

        service.ExecuteReport = ExecuteReport;
        service.LoadReport = LoadReport;

        return service;

        function ExecuteReport(callback) {

            /* Dummy authentication for testing, uses $timeout to simulate api call
             ----------------------------------------------*/
            //$timeout(function () {
            //    var response;
            //    var user = UserService.GetByUsername(username);
            //    if (user !== null && user.password === password) {
            //        response = { success: true };
            //    } else {
            //        response = { success: false, message: 'Username or password is incorrect' };
            //    }
            //    callback(response);
            //}, 1000);

            /* Use this for real execution
             ----------------------------------------------*/
            $http({
                method: "GET",
                url: 'http://localhost:54341/api/Security/GetAll'
            }).then(function mySucces(response) {
                callback(response);
            }, function myError(response) {
                //$scope.error = response.statusText;
            });

        }

        function LoadReport(permissionId, userName, reportId, callback) {

            /* Dummy authentication for testing, uses $timeout to simulate api call
             ----------------------------------------------*/
            //$timeout(function () {
            //    var response;
            //    var user = UserService.GetByUsername(username);
            //    if (user !== null && user.password === password) {
            //        response = { success: true };
            //    } else {
            //        response = { success: false, message: 'Username or password is incorrect' };
            //    }
            //    callback(response);
            //}, 1000);

            /* Use this for real execution
             ----------------------------------------------*/
            $http.post(AppSettings.baseUrl + 'Report/GetReportMetaData', { PermissionId: permissionId, LoginId: userName, ReportId: reportId })
                .then(function (response) {
                    callback(response);
                }, function (response) {
                    callback(response);
                }
            );

        }

         
    }

})();