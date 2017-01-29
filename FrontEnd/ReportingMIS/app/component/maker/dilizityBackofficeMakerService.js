(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .factory('dilizityBackofficeMakerService', dilizityBackofficeMakerService);

    dilizityBackofficeMakerService.$inject = ['$http', '$cookieStore', '$rootScope', '$timeout', 'UserService', 'AppSettings'];
    function dilizityBackofficeMakerService($http, $cookieStore, $rootScope, $timeout, UserService, AppSettings) {
        var service = {};

        service.SaveAsDraft = SaveAsDraft;
        service.CheckerApprovalReady = CheckerApprovalReady;
        service.Delete = Delete;

        return service;

        function SaveAsDraft(permissionName, userName, model, successCallback, errorCallback) {

            console.log("SaveAsDraft Begin");

            $http.post(AppSettings.baseUrl + 'Maker/SaveAsDraft', { PermissionId: permissionName, LoginId: userName, Model: model })
                .then(function (response) {
                    successCallback(response);
                }, function (response) {
                    errorCallback(response);
                }
            );
            console.log("SaveAsDraft End");
        }

        function CheckerApprovalReady(permissionName, userName, model, successCallback, errorCallback) {

            console.log("CheckerApprovalReady Begin");

            $http.post(AppSettings.baseUrl + 'Maker/CheckerApprovalReady', { PermissionId: permissionName, LoginId: userName, Model: model })
                .then(function (response) {
                    successCallback(response);
                }, function (response) {
                    errorCallback(response);
                }
            );
            console.log("CheckerApprovalReady End");
        }

        function Delete(permissionId, userName, makerActivitiesToBeDeleted, successCallback, errorCallback) {
            console.log("Delete Begin");

            $http.post(AppSettings.baseUrl + 'Maker/Delete', { PermissionId: permissionId, LoginId: userName, MakerActivities: makerActivitiesToBeDeleted })
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