
(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('searchRoleController', searchRoleController);

    searchRoleController.$inject = ['$scope', '$stateParams', '$rootScope', 'AuthenticationService', 'UniversalService', 'Notification'];
    function searchRoleController($scope, $stateParams, $rootScope, AuthenticationService, UniversalService, Notification) {
        var vm = this;

        
        vm.slide = false;
        vm.searchRole = searchRole;
        vm.loadScreenPermissionsAndInfo = loadScreenPermissionsAndInfo;
        vm.load = load;
        vm.deleteRoles = deleteRoles;
        vm.isMakerDelete = isMakerDelete;

        vm.roleId = '';
        vm.roleName = '';
        vm.permissionId = '';
        vm.userPermission = {};
        vm.permissionList = [];
        vm.selectedRolePermission = -1;
        vm.selectedRoles = [];
        
        $scope.sort = { fieldName: "Role Id", order: "asc" };

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
              {name:'Role Id',field:'RoleId'},
              {name:'Role Name',field:'RoleName'},
              { name: 'Is System', field: 'IsSystem' },
              { name: 'Updated By', field: 'UpdatedBy' },
              { name: 'Updated On', field: 'UpdatedOn' },
              { name: 'Action', cellTemplate: '<div>'+
                                                '<ul class="nav navbar-right panel_toolbox">'+
	                                                '<li>'+
                                                		'<a ng-show="grid.appScope.vm.userPermission.View===\'Dilizity.Backoffice.Role.View\'" uib-tooltip="View Role" tooltip-placement="left" ui-sref="index.ActionRole({ roleId: row.entity.RoleId, makerId: 0, permissionName: \'Dilizity.Backoffice.Role.View\' })" class="pull-right"><i class="fa fa-eye"></i></a>' +
	                                                '</li>'+
	                                                '<li>'+
		                                                '<a ng-show="grid.appScope.vm.userPermission.Edit===\'Dilizity.Backoffice.Role.Edit\'" uib-tooltip="Edit Role" tooltip-placement="left" ui-sref="index.ActionRole({ roleId: row.entity.RoleId, makerId: 0, permissionName: \'Dilizity.Backoffice.Role.Edit\' })" class="pull-right"><i class="fa fa-pencil-square"></i></a>' +
		                                                '<a ng-show="grid.appScope.vm.userPermission.Edit===\'Dilizity.Backoffice.Role.Edit.Maker\'" uib-tooltip="Edit Role [Maker]" tooltip-placement="left" ui-sref="index.ActionRole({ roleId: row.entity.RoleId, makerId: 0, permissionName: \'Dilizity.Backoffice.Role.Edit.Maker\' })" class="pull-right"><i class="fa fa-pencil-square"></i></a>' +
	                                                '<li>' +
	                                                '<li>' +
		                                                '<a ng-show="grid.appScope.vm.userPermission.Delete===\'Dilizity.Backoffice.Role.Delete\'" uib-tooltip="Delete Role" tooltip-placement="left" ui-sref="index.ActionRole({ roleId: row.entity.RoleId, makerId: 0, permissionName: \'Dilizity.Backoffice.Role.Delete\' })" class="pull-right"><i class="fa fa-trash"></i></a>' +
		                                                '<a ng-show="grid.appScope.vm.userPermission.Delete===\'Dilizity.Backoffice.Role.Delete.Maker\'" uib-tooltip="Delete Role [Maker]" tooltip-placement="left" ui-sref="index.ActionRole({ roleId: row.entity.RoleId, makerId: 0, permissionName: \'Dilizity.Backoffice.Role.Delete.Maker\' })" class="pull-right"><i class="fa fa-trash"></i></a>' +
	                                                '<li>' +
                                                '</ul>' +
                                               '</div>' }
            ],
            data:[],
            exporterCsvFilename: 'Roles.csv',
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
                    vm.selectedRoles.push(row.entity.RoleId);
                }
                else {
                    var pos = vm.selectedRoles.indexOf(row.entity.RoleId);
                    vm.selectedRoles.splice(pos, 1);
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
            searchRole();
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
                          vm.permissionList = data.Data.PermissionList;
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

        function searchRole() {
            console.log("searchRole Begin");
            var tmpUserName = $rootScope.globals.currentUser.username;
            var searchPermissionId = vm.permissionId + ".Search";

            var model = {
                RoleId: vm.roleId,
                RoleName: vm.roleName,
                RolePermissionId: vm.selectedRolePermission,
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
            console.log("searchRole End");
        };

        function deleteRoles() {
            console.log("deleteRoles Begin");
            angular.element('#modal').modal('hide');
            var tmpUserName = $rootScope.globals.currentUser.username;
            //Notification.error({ message: 'Error Bottom Right', positionY: 'bottom', positionX: 'right' });
            var deletePermission = vm.permissionId + ".Delete.Bulk";
            console.log("permissionId", deletePermission);
            console.log("vm.selectedRoles", vm.selectedRoles);

            var model = {
                Roles: vm.selectedRoles
            }

            UniversalService.Do(deletePermission, tmpUserName, model,
                function (response) {
                    console.log("Success!");
                    var data = angular.fromJson(response.data);

                    if (data.ErrorCode == 0) {
                        Notification.success({ message: data.ErrorMessage, positionY: 'bottom', positionX: 'right' });
                        vm.selectedRoles = [];
                        searchRole();
                    }
                    else {
                        Notification.error({ message: data.ErrorMessage, positionY: 'bottom', positionX: 'right' });
                        vm.selectedRoles = [];
                    }
                },
                function (response) {
                    console.log("response!", response);
                    Notification.error({ message: response.statusText, positionY: 'bottom', positionX: 'right' });
                }
            );
            console.log("deleteRoles End");

        };


        function isMakerDelete() {
            console.log("isMakerDelete Begin");
            return HelperService.containsAny(vm.userPermission, ['Maker', 'Delete'])
        };


    }

})();
