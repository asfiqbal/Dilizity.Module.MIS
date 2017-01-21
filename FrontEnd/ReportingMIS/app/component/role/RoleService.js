(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .factory('RoleService', RoleService);

    RoleService.$inject = ['$http', '$cookieStore', '$rootScope', '$timeout', 'UserService', 'AppSettings'];
    function RoleService($http, $cookieStore, $rootScope, $timeout, UserService, AppSettings) {
        var service = {};

        service.Search = Search;
        service.Add = Add;
        service.LoadSearchScreen = LoadSearchScreen;
        service.GetActionRoleScreenInfo = GetActionRoleScreenInfo;
        service.Delete = Delete;

        return service;

        function Search(permissionName, userName, roleId, roleName, rolePermissionId, pageSize, pageNumber, sort, successCallBack, errorCallBack) {
            console.log("SearchRole Begin");

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
            $http.post(AppSettings.baseUrl + 'Role/Search', { PermissionId: permissionName, LoginId: userName, RoleId: roleId, RoleName: roleName, RolePermissionId: rolePermissionId, PageSize: pageSize, PageNumber: pageNumber, Sort: sort })
                .then(function (response) {
                    successCallBack(response);
                }, function (response) {
                    errorCallBack(response);
                }
            );
            console.log("SearchRole End");

        }

        function Add(permissionName, userName, model, successCallback, errorCallback) {

            console.log("AddRole Begin");

            $http.post(AppSettings.baseUrl + 'Role/Add', { PermissionId: permissionName, LoginId: userName, Model: model })
                .then(function (response) {
                    successCallback(response);
                }, function (response) {
                    errorCallback(response);
                }
            );
            console.log("AddRole End");

        }

        function LoadSearchScreen(permissionName, userName, successCallback, errorCallback) {
            console.log("GetScreenPermissions Begin");

            $http.post(AppSettings.baseUrl + 'Role/LoadSearchScreen', { PermissionId: permissionName, LoginId: userName })
                .then(function (response) {
                    successCallback(response);
                }, function (response) {
                    errorCallback(response);
                }
            );
            console.log("GetScreenPermissions End");
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
            console.log("GetActionRoleScreenInfo End");
        }

        function Delete(permissionId, userName, rolesToBeleted, successCallback, errorCallback) {
            console.log("RoleService.Delete Begin");

            $http.post(AppSettings.baseUrl + 'Role/Delete', { PermissionId: permissionId, LoginId: userName, Roles: rolesToBeleted })
                .then(function (response) {
                    successCallback(response);
                }, function (response) {
                    errorCallback(response);
                }
            );
            console.log("RoleService.Delete End");
        }

         
    }

})();