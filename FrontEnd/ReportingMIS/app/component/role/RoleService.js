(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .factory('RoleService', RoleService);

    RoleService.$inject = ['$http', '$cookieStore', '$rootScope', '$timeout', 'UserService', 'AppSettings'];
    function RoleService($http, $cookieStore, $rootScope, $timeout, UserService, AppSettings) {
        var service = {};

        service.Add = Add;
        service.Update = Update;
        //service.LoadSearchScreen = LoadSearchScreen;
        service.GetActionRoleScreenInfo = GetActionRoleScreenInfo;
        service.Delete = Delete;

        return service;

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

        function Update(permissionName, userName, model, successCallback, errorCallback) {

            console.log("AddRole Begin");

            $http.post(AppSettings.baseUrl + 'Role/Update', { PermissionId: permissionName, LoginId: userName, Model: model })
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

        function GetActionRoleScreenInfo(permissionName, userName, roleId, makerId, successCallback, errorCallback) {
            console.log("GetActionRoleScreenInfo Begin");

            $http.post(AppSettings.baseUrl + 'Role/GetActionRoleScreenInfo', { PermissionId: permissionName, LoginId: userName, RoleId: roleId, MakerId: makerId })
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