
(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('searchRoleController', searchRoleController);

    searchRoleController.$inject = ['$scope', '$stateParams', '$rootScope', 'AuthenticationService', 'RoleService', 'AlertService', 'Notification'];
    function searchRoleController($scope, $stateParams, $rootScope, AuthenticationService, RoleService, AlertService, Notification) {
        var vm = this;

        var permissionName = '';
        vm.slide = false;
        vm.searchRole = searchRole;
        vm.addRole = addRole;
        vm.loadScreenPermissionsAndInfo = loadScreenPermissionsAndInfo;
        vm.load = load;
        vm.deleteRoles = deleteRoles;

        vm.roleId = '';
        vm.roleName = '';
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
                                                		'<a ng-show="vm.userPermission.View==Dilizity.Backoffice.Role.View" uib-tooltip="View Role" tooltip-placement="left" ui-sref="index.ActionRole({ roleId: row.entity.RoleId, permissionName: \'Dilizity.Backoffice.Role.View\' })" class="pull-right"><i class="fa fa-eye"></i></a>' +
	                                                '</li>'+
	                                                '<li>'+
		                                                '<a ng-show="vm.userPermission.Edit==Dilizity.Backoffice.Role.Edit" uib-tooltip="Edit Role" tooltip-placement="left" ui-sref="index.ActionRole({ roleId: row.entity.RoleId, permissionName: \'Dilizity.Backoffice.Role.Edit\' })" class="pull-right"><i class="fa fa-pencil-square"></i></a>' +
		                                                '<a ng-show="vm.userPermission.Edit==Dilizity.Backoffice.Role.Edit.Maker" uib-tooltip="Edit Role [Maker]" tooltip-placement="left" ui-sref="index.ActionRole({ roleId: row.entity.RoleId, permissionName: \'Dilizity.Backoffice.Role.Edit.Maker\' })" class="pull-right"><i class="fa fa-pencil-square"></i></a>' +
	                                                '<li>' +
                                                '</ul>'+
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
            RoleService.GetRoleScreenInfo('Dilizity.Backoffice.Role', tmpUserName, function (response) {
                var data = angular.fromJson(response.data);
                vm.userPermission = data.UserPermission;
                vm.permissionList = data.PermissionList;
                console.log("data", data);
                console.log("vm.userPermission.Add", vm.userPermission.Add);
            }, function (response) {
                Notification.error({message: "You don't have permission", positionY: 'bottom', positionX: 'right'});
            });
            console.log("loadScreenPermissionsAndInfo End");
        };


        (function initController() {
            console.log("roleController.initController -> Begin");
            loadScreenPermissionsAndInfo();
            console.log("roleController.initController -> End");
        })();

        function addRole() {
            console.log("addRole Begin");
            //vm.dataLoading = true;
            var tmpUserName = $rootScope.globals.currentUser.username;
            RoleService.AddRole(permissionName, tmpUserName, 1, function (response) {
                vm.MetaReport = response.data;
                vm.reportId = vm.MetaReport.ReportId;
                vm.permissionName = vm.MetaReport.PermissionName;
                console.log("response.data", response.data);
                console.log("vm.MetaReport.DisplayName", vm.MetaReport.DisplayName);
                console.log("loadReport Called");
                vm.fields = vm.MetaReport.fieldCollection;
            });
            console.log("addRole End");
        };

        function searchRole() {
            console.log("searchRole Begin");
            var tmpUserName = $rootScope.globals.currentUser.username;
            vm.permissionName = "Dilizity.Backoffice.Role.Search";
            //console.log("permissionName", vm.permissionName);
            //console.log("roleId", vm.roleId);
            //console.log("roleName", vm.roleName);
            //console.log("selectedRolePermission", vm.selectedRolePermission);
            //console.log("$scope.pagination.pageSize", $scope.pagination.pageSize);
            //console.log("$scope.pagination.pageNumber", $scope.pagination.pageNumber);

            RoleService.SearchRole(vm.permissionName, tmpUserName, vm.roleId, vm.roleName, vm.selectedRolePermission, $scope.pagination.pageSize, $scope.pagination.pageNumber, $scope.sort,
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
            console.log("searchRole End");
        };

        function deleteRoles() {
            console.log("deleteRoles Begin");
            angular.element('#modal').modal('hide');
            var tmpUserName = $rootScope.globals.currentUser.username;
            //Notification.error({ message: 'Error Bottom Right', positionY: 'bottom', positionX: 'right' });
            var deletePermission = "Dilizity.Backoffice.Role.Delete";
            console.log("permissionName", vm.permissionName);
            console.log("vm.selectedRoles", vm.selectedRoles);

            RoleService.DeleteRoles(deletePermission, tmpUserName, vm.selectedRoles,
                function (response) {
                    console.log("Success!");
                    Notification.success({ message: "Deleted Successfully.", positionY: 'bottom', positionX: 'right' });
                },
                function (response) {
                    console.log("response!", response);
                    if (response.status == -1) {
                        Notification.error({ message: "Service Not Available.", positionY: 'bottom', positionX: 'right' });
                    }
                    else {
                        Notification.error({ message: response.statusText, positionY: 'bottom', positionX: 'right' });
                    }
                }
            );
            console.log("deleteRoles End");

        };


    }

})();
