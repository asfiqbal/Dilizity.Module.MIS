(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .factory('dilizityBackofficeMakerService', dilizityBackofficeMakerService);

    dilizityBackofficeMakerService.$inject = ['$http', '$cookieStore', '$rootScope', '$timeout', 'UserService', 'AppSettings'];
    function dilizityBackofficeMakerService($http, $cookieStore, $rootScope, $timeout, UserService, AppSettings) {
        var service = {};

        service.Search = Search;
        service.SaveAsDraft = SaveAsDraft;
        service.CheckerApprovalReady = CheckerApprovalReady;
        service.LoadSearchScreen = LoadSearchScreen;
        //service.GetActionMakerScreenInfo = GetActionMakerScreenInfo;
        service.Delete = Delete;

        return service;

        function Search(permissionId, userName, makerId, selectedPermissionId, pageSize, pageNumber, sort, successCallBack, errorCallBack) {
            console.log("Search Begin");

            /* Use this for real execution
             ----------------------------------------------*/
            $http.post(AppSettings.baseUrl + 'Maker/Search', { PermissionId: permissionId, LoginId: userName, MakerId: makerId, SelectedPermissionId: selectedPermissionId, PageSize: pageSize, PageNumber: pageNumber, Sort: sort })
                .then(function (response) {
                    successCallBack(response);
                }, function (response) {
                    errorCallBack(response);
                }
            );
            console.log("Search End");

        }

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

        function LoadSearchScreen(permissionName, userName, successCallback, errorCallback) {
            console.log("LoadSearchScreen Begin");

            $http.post(AppSettings.baseUrl + 'Maker/LoadSearchScreen', { PermissionId: permissionName, LoginId: userName })
                .then(function (response) {
                    successCallback(response);
                }, function (response) {
                    errorCallback(response);
                }
            );
            console.log("LoadSearchScreen End");
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