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
        service.GetRoleScreenInfo = GetRoleScreenInfo;
        service.GetActionRoleScreenInfo = GetActionRoleScreenInfo;
        service.DeleteRoles = DeleteRoles;

        return service;

        function SearchRole(permissionName, userName, roleId, roleName, rolePermissionId, pageSize, pageNumber, sort, successCallBack, errorCallBack) {

            /* Dummy authentication for testing, uses $timeout to simulate api call
             ----------------------------------------------*/
            //$timeout(function () {
            //    var response = {
            //        data: [
            //        {
            //            "RoleId": 1,
            //            "RoleName": "Administrator",
            //            "CreatedBy": "Admin",
            //            "CreatedOn": "17-Dec-2016"
            //        },
            //        {
            //            "RoleId": 2,
            //            "RoleName": "Test Role 2",
            //            "CreatedBy": "Admin",
            //            "CreatedOn": "17-Dec-2016"
            //        },
            //        {
            //            "RoleId": 3,
            //            "RoleName": "Test Role 3",
            //            "CreatedBy": "Admin",
            //            "CreatedOn": "17-Dec-2016"
            //        },
            //        {
            //            "RoleId": 4,
            //            "RoleName": "Test Role 2",
            //            "CreatedBy": "Admin",
            //            "CreatedOn": "17-Dec-2016"
            //        },
            //        {
            //            "RoleId": 5,
            //            "RoleName": "Test Role 2",
            //            "CreatedBy": "Admin",
            //            "CreatedOn": "17-Dec-2016"
            //        },
            //        {
            //            "RoleId": 6,
            //            "RoleName": "Test Role 2",
            //            "CreatedBy": "Admin",
            //            "CreatedOn": "17-Dec-2016"
            //        },
            //        {
            //            "RoleId": 7,
            //            "RoleName": "Test Role 2",
            //            "CreatedBy": "Admin",
            //            "CreatedOn": "17-Dec-2016"
            //        },
            //        {
            //            "RoleId": 8,
            //            "RoleName": "Test Role 2",
            //            "CreatedBy": "Admin",
            //            "CreatedOn": "17-Dec-2016"
            //        },
            //        {
            //            "RoleId": 9,
            //            "RoleName": "Test Role 2",
            //            "CreatedBy": "Admin",
            //            "CreatedOn": "17-Dec-2016"
            //        },
            //        {
            //            "RoleId": 10,
            //            "RoleName": "Test Role 2",
            //            "CreatedBy": "Admin",
            //            "CreatedOn": "17-Dec-2016"
            //        },
            //        {
            //            "RoleId": 7,
            //        "RoleName": "Test Role 2",
            //        "CreatedBy": "Admin",
            //        "CreatedOn": "17-Dec-2016"
            //    },
            //    {
            //        "RoleId": 8,
            //        "RoleName": "Test Role 2",
            //        "CreatedBy": "Admin",
            //        "CreatedOn": "17-Dec-2016"
            //    },
            //    {
            //        "RoleId": 9,
            //        "RoleName": "Test Role 2",
            //        "CreatedBy": "Admin",
            //        "CreatedOn": "17-Dec-2016"
            //    },
            //        {
            //            "RoleId": 10,
            //            "RoleName": "Test Role 2",
            //            "CreatedBy": "Admin",
            //            "CreatedOn": "17-Dec-2016"
            //        },
            //        {
            //            "RoleId": 7,
            //            "RoleName": "Test Role 2",
            //            "CreatedBy": "Admin",
            //            "CreatedOn": "17-Dec-2016"
            //        },
            //    {
            //        "RoleId": 8,
            //        "RoleName": "Test Role 2",
            //        "CreatedBy": "Admin",
            //        "CreatedOn": "17-Dec-2016"
            //    },
            //    {
            //        "RoleId": 9,
            //        "RoleName": "Test Role 2",
            //        "CreatedBy": "Admin",
            //        "CreatedOn": "17-Dec-2016"
            //    }, {
            //        "RoleId": 10,
            //        "RoleName": "Test Role 2",
            //        "CreatedBy": "Admin",
            //        "CreatedOn": "17-Dec-2016"
            //    }]
            //    };

            //    successCallBack(response);
            //}, 1000);

            /* Use this for real execution
             ----------------------------------------------*/
            $http.post(AppSettings.baseUrl + 'Role/SearchRole', { PermissionId: permissionName, LoginId: userName, RoleId: roleId, RoleName: roleName, RolePermissionId: rolePermissionId, PageSize: pageSize, PageNumber:pageNumber, Sort:sort})
                .then(function (response) {
                    successCallBack(response);
                }, function (response) {
                    errorCallBack(response);
                }
            );

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

        function GetRoleScreenInfo(permissionName, userName, successCallback, errorCallback) {
            console.log("GetScreenPermissions Begin");

            $http.post(AppSettings.baseUrl + 'Role/GetRoleScreenInfo', { PermissionId: permissionName, LoginId: userName })
                .then(function (response) {
                    successCallback(response);
                }, function (response) {
                    errorCallback(response);
                }
            );
            console.log("GetScreenPermissions Begin");
        }

        function GetActionRoleScreenInfo(permissionName, userName, roleId, successCallback, errorCallback) {
            console.log("GetActionRoleScreenInfo Begin");

            $http.post(AppSettings.baseUrl + 'Role/GetActionRoleScreenInfo', { PermissionId: permissionName, LoginId: userName, RoleId: roleId })
                .then(function (response) {
                    successCallback(response);
                }, function (response) {
                    errorCallback(response);
                }
            );
            console.log("GetActionRoleScreenInfo Begin");
        }

        function DeleteRoles(permissionId, userName, rolesToBeleted, successCallback, errorCallback) {
            console.log("RoleService.DeleteRoles Begin");

            $http.post(AppSettings.baseUrl + 'Role/DeleteRoles', { PermissionId: permissionId, LoginId: userName, Roles: rolesToBeleted })
                .then(function (response) {
                    successCallback(response);
                }, function (response) {
                    errorCallback(response);
                }
            );
            console.log("RoleService.DeleteRoles Begin");
        }

         
    }

})();