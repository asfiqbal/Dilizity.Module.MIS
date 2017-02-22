
(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('searchPasswordPolicyController', searchPasswordPolicyController);

    searchPasswordPolicyController.$inject = ['$scope', '$stateParams', '$rootScope', 'AuthenticationService', 'UniversalService', 'Notification'];
    function searchPasswordPolicyController($scope, $stateParams, $rootScope, AuthenticationService, UniversalService, Notification) {
        var vm = this;

        vm.slide = false;
        vm.search = search;
        vm.loadScreenPermissionsAndInfo = loadScreenPermissionsAndInfo;
        vm.load = load;
        vm.delete = deletes;
        vm.isMakerDelete = isMakerDelete;

        vm.id = '';
        vm.name = '';
        vm.permissionId = '';
        vm.userPermission = {};
        vm.selectedPasswordPolicy = [];
        
        $scope.sort = { fieldName: "Id", order: "asc" };

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
              {name:'Id',field:'Id'},
              {name:'Name',field:'Name'},
              {name:'Login Id', field: 'LoginId' },
              {name:'Mobile Number', field: 'MobileNumber' },
              {name:'Email', field: 'Email' },
              {name:'Account Locked', field: 'AccountLocked' },
              {name:'Updated By', field: 'UpdatedBy' },
              {name:'Updated On', field: 'UpdatedOn' },
              {name:'Action', cellTemplate: '<div>'+
                                                '<ul class="nav navbar-right panel_toolbox">'+
	                                                '<li>'+
                                                		'<a ng-show="grid.appScope.vm.userPermission.View===\'Dilizity.Backoffice.PasswordPolicy.View\'" uib-tooltip="View Password Policy" tooltip-placement="left" ui-sref="index.ActionPasswordPolicy({ id: row.entity.Id, makerId: 0, permissionName: \'Dilizity.Backoffice.PasswordPolicy.View\' })" class="pull-right"><i class="fa fa-eye"></i></a>' +
	                                                '</li>'+
	                                                '<li>'+
		                                                '<a ng-show="grid.appScope.vm.userPermission.Edit===\'Dilizity.Backoffice.PasswordPolicy.Edit\'" uib-tooltip="Edit Password Policy" tooltip-placement="left" ui-sref="index.ActionPasswordPolicy({ id: row.entity.Id, makerId: 0, permissionName: \'Dilizity.Backoffice.PasswordPolicy.Edit\' })" class="pull-right"><i class="fa fa-pencil-square"></i></a>' +
		                                                '<a ng-show="grid.appScope.vm.userPermission.Edit===\'Dilizity.Backoffice.PasswordPolicy.Edit.Maker\'" uib-tooltip="Edit Password Policy [Maker]" tooltip-placement="left" ui-sref="index.ActionPasswordPolicy({ id: row.entity.UserId, makerId: 0, permissionName: \'Dilizity.Backoffice.PasswordPolicy.Edit.Maker\' })" class="pull-right"><i class="fa fa-pencil-square"></i></a>' +
	                                                '<li>' +
	                                                '<li>' +
		                                                '<a ng-show="grid.appScope.vm.userPermission.Delete===\'Dilizity.Backoffice.PasswordPolicy.Delete\'" uib-tooltip="Delete Password Policy" tooltip-placement="left" ui-sref="index.ActionPasswordPolicy({ id: row.entity.Id, makerId: 0, permissionName: \'Dilizity.Backoffice.PasswordPolicy.Delete\' })" class="pull-right"><i class="fa fa-trash"></i></a>' +
		                                                '<a ng-show="grid.appScope.vm.userPermission.Delete===\'Dilizity.Backoffice.PasswordPolicy.Delete.Maker\'" uib-tooltip="Delete Password Policy [Maker]" tooltip-placement="left" ui-sref="index.ActionPasswordPolicy({ id: row.entity.Id, makerId: 0, permissionName: \'Dilizity.Backoffice.PasswordPolicy.Delete.Maker\' })" class="pull-right"><i class="fa fa-trash"></i></a>' +
	                                                '<li>' +
                                                '</ul>' +
                                               '</div>' }
            ],
            data:[],
            exporterCsvFilename: 'PasswordPolicy.csv',
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
                    vm.selectedPasswordPolicy.push(row.entity.UserId);
                }
                else {
                    var pos = vm.selectedPasswordPolicy.indexOf(row.entity.UserId);
                    vm.selectedPasswordPolicy.splice(pos, 1);
                    //console.log(row.entity.RoleId);
                }
            });

            $scope.gridApi.selection.on.rowSelectionChangedBatch($scope, function (rows) {
                var msg = 'rows changed ' + rows.length;
                console.log(msg);
            });
            }
        };

        //$scope.gridOptions.multiSelect = true;

        //$scope.editClickHandler = function (val) {
        //    console.log(val);
        //    alert('Name: ' + val);
        //};


        function load() {
            console.log("load Begin");
            searchUser();
            console.log("load End");
        };

        function loadScreenPermissionsAndInfo() {
            console.log("loadScreenPermissionsAndInfo Begin");
            var tmpUserName = $rootScope.globals.currentUser.username;
            
            UniversalService.Do(vm.permissionId, tmpUserName, null,
                  function (response) {
                      var data = angular.fromJson(response.data);

                      if (data.ErrorCode == 0) {
                          vm.userPermission = data.Data.UserPermission;
                      }
                      else {
                          Notification.error({ message: data.ErrorMessage, positionY: 'bottom', positionX: 'right' });
                      }
                  }, function (response) {
                      Notification.error({ message: response.statusText, positionY: 'bottom', positionX: 'right' });
                  });
            console.log("loadScreenPermissionsAndInfo End");
        };


        (function initController() {
            console.log("roleController.initController -> Begin");
            console.log("$stateParams", $stateParams);
            vm.permissionId = $stateParams.permissionId;
            loadScreenPermissionsAndInfo();
            console.log("roleController.initController -> End");
        })();

        function search() {
            console.log("searchUser Begin");
            var tmpUserName = $rootScope.globals.currentUser.username;
            var searchPermissionId = vm.permissionId + ".Search";

            var model = {
                Id: vm.id,
                Name: vm.name,
                PageSize: $scope.pagination.pageSize,
                PageNumber: $scope.pagination.pageNumber,
                Sort: $scope.sort
            }

            UniversalService.Do(searchPermissionId, tmpUserName, model,
                function (response) {
                    console.log("Success!");

                    var data = angular.fromJson(response.data);

                    if (data.ErrorCode == 0) {
                        $scope.gridOptions.data = data.Data;
                        $scope.pagination.totalItems = 25;
                    }
                    else
                    {
                        Notification.error({ message: data.ErrorMessage, positionY: 'bottom', positionX: 'right' });
                    }
                },
                function (response) {
                    console.log("response!", response);
                    Notification.error({ message: response.statusText, positionY: 'bottom', positionX: 'right' });
                }
            );
            console.log("searchUser End");
        };

        function deletes() {
            console.log("deleteUsers Begin");
            angular.element('#modal').modal('hide');
            var tmpUserName = $rootScope.globals.currentUser.username;
            //Notification.error({ message: 'Error Bottom Right', positionY: 'bottom', positionX: 'right' });
            var deletePermission = vm.permissionId + ".Delete.Bulk";
            console.log("permissionId", deletePermission);
            console.log("vm.selectedPasswordPolicy", vm.selectedPasswordPolicy);

            var model = {
                Users: vm.selectedPasswordPolicy
            }

            UniversalService.Do(deletePermission, tmpUserName, model,
                function (response) {
                    console.log("Success!");
                    var data = angular.fromJson(response.data);

                    if (data.ErrorCode == 0) {
                        Notification.success({ message: data.ErrorMessage, positionY: 'bottom', positionX: 'right' });
                        vm.selectedPasswordPolicy = [];
                        searchUser();
                    }
                    else {
                        Notification.error({ message: data.ErrorMessage, positionY: 'bottom', positionX: 'right' });
                        vm.selectedPasswordPolicy = [];
                    }
                },
                function (response) {
                    console.log("response!", response);
                    Notification.error({ message: response.statusText, positionY: 'bottom', positionX: 'right' });
                }
            );
            console.log("deleteUsers End");

        };


        function isMakerDelete() {
            console.log("isMakerDelete Begin");
            return HelperService.containsAny(vm.userPermission, ['Maker', 'Delete'])
        };


    }

})();
