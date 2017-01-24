
(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('dilizityBackofficeCheckerController', dilizityBackofficeCheckerController);

    dilizityBackofficeCheckerController.$inject = ['$scope', '$stateParams', '$rootScope', 'AuthenticationService', 'dilizityBackofficeCheckerService', 'AlertService', 'Notification'];
    function dilizityBackofficeCheckerController($scope, $stateParams, $rootScope, AuthenticationService, dilizityBackofficeCheckerService, AlertService, Notification) {
        var vm = this;

        var permissionId = '';
        vm.slide = false;
        vm.searchMakerActivity = searchMakerActivity;
        //vm.updateMakerActivity = updateMakerActivity;
        vm.loadScreenPermissionsAndInfo = loadScreenPermissionsAndInfo;
        vm.load = load;

        vm.makerId = '';
        vm.userPermission = {};
        vm.permissionList = [];
        vm.selectedPermissions = -1;
        vm.selectedMakerActivities = [];
        
        $scope.sort = { fieldName: "Maker Id", order: "asc" };

        $scope.pagination = {
            pageSize: 15,
            pageNumber: 1,
            totalItems: null,
            getTotalPages: function () {
                //console.log("getTotalPages Begin");
                return Math.ceil(this.pageNumber * this.pageSize);
            },
            nextPage: function () {
                console.log("nextPage Begin");
                //if (this.pageNumber < this.getTotalPages()) {
                    this.pageNumber++;
                    load();
                //}
                console.log("nextPage End");
            },
            previousPage: function () {
                console.log("previousPage Begin");
                if (this.pageNumber > 1) {
                    this.pageNumber--;
                    load();
                }
                console.log("previousPage End");
            }
        };

        $scope.gridOptions = {
            enableGridMenu: true,
            enableSelectAll: true,
            multiSelect: true,
            enablePaginationControls: false,
            useExternalPagination: true,
            useExternalSorting: true,
            columnDefs:[ 
              { name:'Maker Id',field:'MakerId'},
              { name: 'Permission Name', field: 'PermissionName' },
              { name: 'Status', field: 'Status' },
              { name: 'Created By', field: 'CreatedBy' },
              { name: 'Created On', field: 'CreatedOn' },
              { name: 'Updated By', field: 'UpdatedBy' },
              { name: 'Updated On', field: 'UpdatedOn' },
              { name: 'ActionUrl', field: 'ActionUrl' },
              {
                  name: 'Action', cellTemplate: '<div>' +
                                                '<ul class="nav navbar-right panel_toolbox">'+
	                                                '<li>'+
                                                		'<a ng-show="vm.userPermission.View==Dilizity.Backoffice.Maker.View" uib-tooltip="View Role" tooltip-placement="left" ui-sref="{{row.entity.ActionUrl}}" class="pull-right"><i class="fa fa-eye"></i></a>' +
	                                                '</li>'+
	                                                '<li>'+
		                                                '<a ng-show="vm.userPermission.Edit==Dilizity.Backoffice.Maker.Edit" uib-tooltip="Edit Role" tooltip-placement="left" ui-sref="{{row.entity.ActionUrl}}" class="pull-right"><i class="fa fa-pencil-square"></i></a>' +
	                                                '<li>' +
                                                '</ul>'+
                                               '</div>'
              }
            ],
            data:[],
            exporterCsvFilename: 'MakerList.csv',
            onRegisterApi: function (gridApi) {
            $scope.gridApi = gridApi;
            $scope.gridApi.core.on.sortChanged($scope, function (grid, sortColumns) {
                    console.log("sortChanged Begin");
                    $scope.sort = {};
                    angular.forEach(sortColumns, function (sortColumn) {
                        $scope.sort = {
                            fieldName: sortColumn.name,
                            order: sortColumn.sort.direction
                        };
                    });
                    console.log("sort", $scope.sort);
                    load();
                    console.log("sortChanged End");

            });
            $scope.gridApi.selection.on.rowSelectionChanged($scope, function (row) {
                var msg = 'row selected ' + row.isSelected;
                if (row.isSelected){
                    vm.selectedMakerActivities.push(row.entity.MakerId);
                }
                else {
                    var pos = vm.selectedMakerActivities.indexOf(row.entity.MakerId);
                    vm.selectedMakerActivities.splice(pos, 1);
                    //console.log(row.entity.RoleId);
                }
            });

            $scope.gridApi.selection.on.rowSelectionChangedBatch($scope, function (rows) {
                var msg = 'rows changed ' + rows.length;
                console.log(msg);
            });
            }
        };

        function load() {
            console.log("load Begin");
            searchMakerActivity();
            console.log("load End");
        };

        function loadScreenPermissionsAndInfo() {
            console.log("loadScreenPermissionsAndInfo Begin");
            var tmpUserName = $rootScope.globals.currentUser.username;
            dilizityBackofficeCheckerService.LoadSearchScreen(permissionId, tmpUserName, function (response) {
                var data = angular.fromJson(response.data);
                vm.userPermission = data.UserPermission;
                vm.permissionList = data.PermissionList;
                console.log("data", data);
            }, function (response) {
                Notification.error({message: "You don't have permission", positionY: 'bottom', positionX: 'right'});
            });
            console.log("loadScreenPermissionsAndInfo End");
        };


        (function initController() {
            console.log("dilizityBackofficeCheckerController.initController -> Begin");

            permissionId = $stateParams.permissionId;
            console.log("permissionId", permissionId);

            loadScreenPermissionsAndInfo();
            console.log("dilizityBackofficeCheckerController.initController -> End");
        })();


        function searchMakerActivity() {
            console.log("searchMakerActivity Begin");
            var tmpUserName = $rootScope.globals.currentUser.username;

            var searchPermissionId = permissionId + '.Search';

            dilizityBackofficeCheckerService.Search(searchPermissionId, tmpUserName, vm.makerId, vm.selectedPermissions, $scope.pagination.pageSize, $scope.pagination.pageNumber, $scope.sort,
                function (response) {
                    console.log("Success!");
                    $scope.gridOptions.data = response.data;
                    $scope.pagination.totalItems = 25;
                },
                function (response) {
                    console.log("response!", response);
                    if (response.status == -1) {
                        Notification.error({message: "Service Not Available.", positionY: 'bottom', positionX: 'right' });
                    }
                    else {
                        Notification.error({ message: response.statusText, positionY: 'bottom', positionX: 'right' });
                    }
                }
            );
            console.log("searchMakerActivity End");
        };



    }

})();
