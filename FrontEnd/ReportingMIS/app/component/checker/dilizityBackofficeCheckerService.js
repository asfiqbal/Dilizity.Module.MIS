(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .factory('dilizityBackofficeCheckerService', dilizityBackofficeCheckerService);

    dilizityBackofficeCheckerService.$inject = ['$http', '$cookieStore', '$rootScope', '$timeout', 'UserService', 'AppSettings'];
    function dilizityBackofficeCheckerService($http, $cookieStore, $rootScope, $timeout, UserService, AppSettings) {
        var service = {};

        service.Approve = Approve;
        service.CorrectionRequired = CorrectionRequired;
        service.Reject = Reject;

        return service;

        function CorrectionRequired(permissionName, userName, model, successCallback, errorCallback) {

            console.log("UpdateMakerActivity Begin");

            $http.post(AppSettings.baseUrl + 'Checker/CorrectionRequired', { PermissionId: permissionName, LoginId: userName, Model: model })
                .then(function (response) {
                    successCallback(response);
                }, function (response) {
                    errorCallback(response);
                }
            );
            console.log("UpdateMakerActivity End");
        }

        function Approve(permissionName, userName, model, successCallback, errorCallback) {

            console.log("Add Begin");

            $http.post(AppSettings.baseUrl + 'Checker/Approve', { PermissionId: permissionName, LoginId: userName, Model: model })
                .then(function (response) {
                    successCallback(response);
                }, function (response) {
                    errorCallback(response);
                }
            );
            console.log("Add End");
        }

        //function LoadSearchScreen(permissionName, userName, successCallback, errorCallback) {
        //    console.log("GetScreenPermissions Begin");

        //    $http.post(AppSettings.baseUrl + 'Checker/LoadSearchScreen', { PermissionId: permissionName, LoginId: userName })
        //        .then(function (response) {
        //            successCallback(response);
        //        }, function (response) {
        //            errorCallback(response);
        //        }
        //    );
        //    console.log("GetScreenPermissions End");
        //}

        //function GetActionMakerScreenInfo(permissionName, userName, makerId, successCallback, errorCallback) {
        //    console.log("GetActionMakerScreenInfo Begin");

        //    $http.post(AppSettings.baseUrl + 'Maker/GetActionMakerScreenInfo', { PermissionId: permissionName, LoginId: userName, MakerId: makerId })
        //        .then(function (response) {
        //            successCallback(response);
        //        }, function (response) {
        //            errorCallback(response);
        //        }
        //    );
        //    console.log("GetActionMakerScreenInfo End");
        //}

        function Reject(permissionId, userName, makerActivitiesToBeDeleted, successCallback, errorCallback) {
            console.log("Delete Begin");

            $http.post(AppSettings.baseUrl + 'Checker/Reject', { PermissionId: permissionId, LoginId: userName, MakerActivities: makerActivitiesToBeDeleted })
                .then(function (response) {
                    successCallback(response);
                }, function (response) {
                    errorCallback(response);
                }
            );
            console.log("DeleteDelete End");
        }

         
    }

})();