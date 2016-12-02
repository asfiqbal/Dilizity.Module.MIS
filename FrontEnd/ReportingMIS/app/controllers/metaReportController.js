
(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('metaReportController', metaReportController);

    metaReportController.$inject = ['$scope', '$stateParams', '$rootScope', 'AuthenticationService', 'ReportService', 'FlashService'];
    function metaReportController($scope, $stateParams, $rootScope, AuthenticationService, ReportService, FlashService) {
        var vm = this;

        var reportId = -1;
        var permissionId = '';
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
            permissionId = $stateParams.permissionId;
            console.log("$stateParams.reportId", $stateParams.reportId);
            console.log("$stateParams.permissionId", $stateParams.permissionId);

            console.log("metaReportController.initController -> End");
        })();

        function loadReport() {
            console.log("loadReport Begin");
            //vm.dataLoading = true;
            var tmpUserName = $rootScope.globals.currentUser.username;
            ReportService.LoadReport(permissionId, tmpUserName, reportId, function (response) {
                vm.MetaReport = response.data;
                console.log("response.data", response.data);
                console.log("vm.MetaReport.DisplayName", vm.MetaReport.DisplayName);
                console.log("loadReport Called");
                vm.fields = [
                        {
                            className: 'row row-no-padding',
                            fieldGroup: [
                            {
                                className: 'col-md-4 ',
                                key: 'first_name',
                                type: 'input',
                                templateOptions: {
                                    type: 'text',
                                    label: 'First Name',
                                    placeholder: 'Enter your first name',
                                    required: true
                                }
                            },
                            {
                                className: 'col-md-4 ',
                                key: 'last_name',
                                type: 'input',
                                templateOptions: {
                                    type: 'text',
                                    label: 'Last Name',
                                    placeholder: 'Enter your last name',
                                    required: true
                                }
                            },
                            {
                                className: 'col-md-4 ',
                                key: 'state',
                                type: 'select',
                                templateOptions: {
                                    label: 'State',
                                    required: true,
                                    options: [
                                  { name: 'Tennessee', value: 'TN' },
                                  { name: 'Texas', value: 'TX' }
                                    ]
                                }
                            },
                            {
                                className: 'col-md-4 ',
                                key: 'email',
                                type: 'input',
                                templateOptions: {
                                    type: 'email',
                                    label: 'Email address',
                                    placeholder: 'Enter email',
                                    required: true
                                }
                            },
                            {
                                className: 'col-md-4 ',
                                key: 'date1',
                                type: 'datepicker',
                                templateOptions: {
                                    label: 'Date 1',
                                    type: 'text',
                                    placeholder: 'Enter Date',
                                    datepickerPopup: 'dd-MMMM-yyyy',
                                    required: true
                                }
                            }]
                        }];
                //,
                //        {
                //            className: 'row row-no-padding',
                //            fieldGroup: [
                //            {
                //                className: 'col-xs-4 ',
                //                key: 'state',
                //                type: 'select',
                //                templateOptions: {
                //                    label: 'State',
                //                    required: true,
                //                    options: [
                //                  { name: 'Tennessee', value: 'TN' },
                //                  { name: 'Texas', value: 'TX' }
                //                    ]
                //                }
                //            },
                //            {
                //                className: 'col-xs-4 ',
                //                key: 'email',
                //                type: 'input',
                //                templateOptions: {
                //                    type: 'email',
                //                    label: 'Email address',
                //                    placeholder: 'Enter email',
                //                    required: true
                //                }
                //            }],
                //        }
                //];
            });
            console.log("loadReport End");
        };

        loadReport();

        function reportSubmit() {
            //vm.dataLoading = true;
            alert("1");
            console.log("vm.model", vm.model);

            //ReportService.ExecuteReport(function (response) {
            //    $scope.gridOptions.data = response.data;
            //    console.log(response.data[0].UserId);
            //});
            //vm.dataLoading = false;

        };
    }

})();
