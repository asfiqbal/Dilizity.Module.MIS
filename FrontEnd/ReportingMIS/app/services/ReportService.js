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

        function ExecuteReport(reportId, permissionName, userName, model, successCallBack, errorCallBack) {

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
            //}, 1000);111

            /* Use this for real execution
             ----------------------------------------------*/
            $http.post(AppSettings.baseUrl + 'Report/ExecuteReport', { PermissionId: permissionName, LoginId: userName, ReportId: reportId, fieldCollection: model })
                .then(function (response) {
                    successCallBack(response);
                }, function (response) {
                    errorCallBack(response);
                }
            );

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