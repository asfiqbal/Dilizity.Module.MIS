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

        function SearchRole(permissionName, userName, roleId, roleName, pageSize, pageNumber, sort, successCallBack, errorCallBack) {

            /* Dummy authentication for testing, uses $timeout to simulate api call
             ----------------------------------------------*/
            $timeout(function () {
                var response = {
                    data: [
                    {
                        "RoleId": 1,
                        "RoleName": "Administrator",
                        "CreatedBy": "Admin",
                        "CreatedOn": "17-Dec-2016"
                    },
                    {
                        "RoleId": 2,
                        "RoleName": "Test Role 2",
                        "CreatedBy": "Admin",
                        "CreatedOn": "17-Dec-2016"
                    },
                    {
                        "RoleId": 3,
                        "RoleName": "Test Role 3",
                        "CreatedBy": "Admin",
                        "CreatedOn": "17-Dec-2016"
                    },
                    {
                        "RoleId": 4,
                        "RoleName": "Test Role 2",
                        "CreatedBy": "Admin",
                        "CreatedOn": "17-Dec-2016"
                    },
                    {
                        "RoleId": 5,
                        "RoleName": "Test Role 2",
                        "CreatedBy": "Admin",
                        "CreatedOn": "17-Dec-2016"
                    },
                    {
                        "RoleId": 6,
                        "RoleName": "Test Role 2",
                        "CreatedBy": "Admin",
                        "CreatedOn": "17-Dec-2016"
                    },
                    {
                        "RoleId": 7,
                        "RoleName": "Test Role 2",
                        "CreatedBy": "Admin",
                        "CreatedOn": "17-Dec-2016"
                    },
                    {
                        "RoleId": 8,
                        "RoleName": "Test Role 2",
                        "CreatedBy": "Admin",
                        "CreatedOn": "17-Dec-2016"
                    },
                    {
                        "RoleId": 9,
                        "RoleName": "Test Role 2",
                        "CreatedBy": "Admin",
                        "CreatedOn": "17-Dec-2016"
                    },
                    {
                        "RoleId": 10,
                        "RoleName": "Test Role 2",
                        "CreatedBy": "Admin",
                        "CreatedOn": "17-Dec-2016"
                    },
                    {
                        "RoleId": 7,
                    "RoleName": "Test Role 2",
                    "CreatedBy": "Admin",
                    "CreatedOn": "17-Dec-2016"
                },
                {
                    "RoleId": 8,
                    "RoleName": "Test Role 2",
                    "CreatedBy": "Admin",
                    "CreatedOn": "17-Dec-2016"
                },
                {
                    "RoleId": 9,
                    "RoleName": "Test Role 2",
                    "CreatedBy": "Admin",
                    "CreatedOn": "17-Dec-2016"
                },
                    {
                        "RoleId": 10,
                        "RoleName": "Test Role 2",
                        "CreatedBy": "Admin",
                        "CreatedOn": "17-Dec-2016"
                    },
                    {
                        "RoleId": 7,
                        "RoleName": "Test Role 2",
                        "CreatedBy": "Admin",
                        "CreatedOn": "17-Dec-2016"
                    },
                {
                    "RoleId": 8,
                    "RoleName": "Test Role 2",
                    "CreatedBy": "Admin",
                    "CreatedOn": "17-Dec-2016"
                },
                {
                    "RoleId": 9,
                    "RoleName": "Test Role 2",
                    "CreatedBy": "Admin",
                    "CreatedOn": "17-Dec-2016"
                }, {
                    "RoleId": 10,
                    "RoleName": "Test Role 2",
                    "CreatedBy": "Admin",
                    "CreatedOn": "17-Dec-2016"
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