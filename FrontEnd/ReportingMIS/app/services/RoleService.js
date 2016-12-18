(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .factory('RoleService', RoleService);

    RoleService.$inject = ['$http', '$cookieStore', '$rootScope', '$timeout', 'UserService', 'AppSettings'];
    function RoleService($http, $cookieStore, $rootScope, $timeout, UserService, AppSettings) {
        var service = {};

        service.SearchRole = SearchRole;
        service.AddRole = AddRole;

        return service;

        function SearchRole(permissionName, userName, roleId, roleName, successCallBack, errorCallBack) {

            /* Dummy authentication for testing, uses $timeout to simulate api call
             ----------------------------------------------*/
            $timeout(function () {
                var response = {
                    data: [
                    {
                        "Role Id": 1,
                        "Role Name": "Administrator",
                        "Created By": "Admin",
                        "Created On": "17-Dec-2016"
                    },
                    {
                        "Role Id": 2,
                        "Role Name": "Test Role 2",
                        "Created By": "Admin",
                        "Created On": "17-Dec-2016"
                    },
                    {
                        "Role Id": 3,
                        "Role Name": "Test Role 3",
                        "Created By": "Admin",
                        "Created On": "17-Dec-2016"
                    }]
                };

                successCallBack(response);
            }, 1000);

            /* Use this for real execution
             ----------------------------------------------*/
            //$http.post(AppSettings.baseUrl + 'Report/ExecuteReport', { PermissionId: permissionName, LoginId: userName, ReportId: reportId, fieldCollection: model })
            //    .then(function (response) {
            //        successCallBack(response);
            //    }, function (response) {
            //        errorCallBack(response);
            //    }
            //);

        }

        function AddRole(permissionId, userName, reportId, callback) {

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
            //$http.post(AppSettings.baseUrl + 'Report/GetReportMetaData', { PermissionId: permissionId, LoginId: userName, ReportId: reportId })
            //    .then(function (response) {
            //        callback(response);
            //    }, function (response) {
            //        callback(response);
            //    }
            //);

        }

         
    }

})();