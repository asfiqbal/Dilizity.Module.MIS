(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .factory('dilizityBackofficeCheckerService', dilizityBackofficeCheckerService);

    dilizityBackofficeCheckerService.$inject = ['$http', '$cookieStore', '$rootScope', '$timeout', 'UserService', 'AppSettings'];
    function dilizityBackofficeCheckerService($http, $cookieStore, $rootScope, $timeout, UserService, AppSettings) {
        var service = {};

        service.Search = Search;
        service.Approve = Approve;
        service.CorrectionRequired = CorrectionRequired;
        service.Reject = Reject;
        service.LoadSearchScreen = LoadSearchScreen;
        //service.GetActionMakerScreenInfo = GetActionMakerScreenInfo;

        return service;

        function Search(permissionId, userName, makerId, selectedPermissionId, pageSize, pageNumber, sort, successCallBack, errorCallBack) {
            console.log("SearchMakerActivity Begin");

            /* Use this for real execution
             ----------------------------------------------*/
            $http.post(AppSettings.baseUrl + 'Checker/Search', { PermissionId: permissionId, LoginId: userName, MakerId: makerId, SelectedPermissionId: selectedPermissionId, PageSize: pageSize, PageNumber: pageNumber, Sort: sort })
                .then(function (response) {
                    successCallBack(response);
                }, function (response) {
                    errorCallBack(response);
                }
            );
            console.log("SearchMakerActivity End");

        }

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

        function LoadSearchScreen(permissionName, userName, successCallback, errorCallback) {
            console.log("GetScreenPermissions Begin");

            $http.post(AppSettings.baseUrl + 'Checker/LoadSearchScreen', { PermissionId: permissionName, LoginId: userName })
                .then(function (response) {
                    successCallback(response);
                }, function (response) {
                    errorCallback(response);
                }
            );
            console.log("GetScreenPermissions End");
        }

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