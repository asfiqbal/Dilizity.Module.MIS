
(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('metaReportController', metaReportController);

    metaReportController.$inject = ['$scope', '$stateParams', '$rootScope', 'AuthenticationService', 'ReportService', 'FlashService'];
    function metaReportController($scope, $stateParams, $rootScope, AuthenticationService, ReportService, FlashService) {
        var vm = this;

        var reportId = -1;
        var permissionName = '';
        vm.model = {};

        $scope.gridOptions = {
            enableGridMenu: true,
            enableSelectAll: true,
            data:[],
            exporterCsvFilename: 'myFile.csv',
            onRegisterApi: function (gridApi) {
                $scope.gridApi = gridApi;
            }
        };

        vm.reportSubmit = reportSubmit;

        vm.loadReport = loadReport;

        (function initController() {
            console.log("metaReportController.initController -> Begin");
            reportId = $stateParams.reportId;
            permissionName = $stateParams.PermissionName;
            console.log("reportId", reportId);
            console.log("permissionName", permissionName);

            console.log("metaReportController.initController -> End");
        })();

        function loadReport() {
            console.log("loadReport Begin");
            //vm.dataLoading = true;
            var tmpUserName = $rootScope.globals.currentUser.username;
            ReportService.LoadReport(permissionName, tmpUserName, reportId, function (response) {
                vm.MetaReport = response.data;
                vm.reportId = vm.MetaReport.ReportId;
                vm.permissionName = vm.MetaReport.PermissionName;
                console.log("response.data", response.data);
                console.log("vm.MetaReport.DisplayName", vm.MetaReport.DisplayName);
                console.log("loadReport Called");
                vm.fields = vm.MetaReport.fieldCollection;
            });
            console.log("loadReport End");
        };

        loadReport();

        function reportSubmit() {
            //vm.dataLoading = true;
            var tmpUserName = $rootScope.globals.currentUser.username;
            var stringModel = JSON.stringify(vm.model);
            console.log("stringModel", stringModel);

            ReportService.ExecuteReport(vm.reportId, vm.permissionName, tmpUserName, vm.model,
                function (response) {
                $scope.gridOptions.data = response.data;
                console.log("Success!");
                },
                function (response) {
                    console.log("Error!");
                }
            );
            //vm.dataLoading = false;

        };
    }

})();
