
(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('roleController', roleController);

    roleController.$inject = ['$scope', '$stateParams', '$rootScope', 'AuthenticationService', 'RoleService', 'AlertService'];
    function roleController($scope, $stateParams, $rootScope, AuthenticationService, RoleService, AlertService) {
        var vm = this;

        var permissionName = '';
        vm.searchRole = searchRole;
        vm.addRole = addRole;
        vm.loadScreenPermissionsAndInfo = loadScreenPermissionsAndInfo;
        vm.load = load;
        vm.roleId = '';
        vm.roleName = '';
        vm.userPermission = {};
        vm.permissionList = [];
        vm.selectedRolePermission = -1;
        

        $scope.sort = { fieldName: "Role Id", order: "asc" };

        $scope.pagination = {
            pageSize: 15,
            pageNumber: 1,
            totalItems: null,
            getTotalPages: function () {
                console.log("getTotalPages Begin");
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
              { name: 'Action', cellTemplate: '<div><button ng-show="vm.userPermission.Edit==Dilizity.Backoffice.Role.Edit" class="pull-right" ng-click="grid.appScope.editClickHandler(row.entity.RoleId)">Edit</button><button ng-show="vm.userPermission.View==Dilizity.Backoffice.Role.View" class="pull-right" ng-click="grid.appScope.editClickHandler(row.entity.RoleId)">View</button></div>' }
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
            }
        };

        //$scope.gridOptions.multiSelect = true;

        $scope.editClickHandler = function (val) {
            console.log(val);
            alert('Name: ' + val);
        };

        function load() {
            console.log("load Begin");
            searchRole();
            console.log("load End");
        };

        function loadScreenPermissionsAndInfo() {
            console.log("loadScreenPermissionsAndInfo Begin");
            var tmpUserName = $rootScope.globals.currentUser.username;
            RoleService.GetScreenPermissions('Dilizity.Backoffice.Role', tmpUserName, function (response) {
                var data = angular.fromJson(response.data);
                vm.userPermission = data.UserPermission;
                vm.permissionList = data.PermissionList;
                console.log("data", data);
                console.log("vm.userPermission.Add", vm.userPermission.Add);
            }, function (response) {
                AlertService.Add("Error", "You don't have permission");
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
            //vm.dataLoading = true;
            console.log("searchRole Begin");
            var tmpUserName = $rootScope.globals.currentUser.username;
            vm.permissionName = "Dilizity.Backoffice.Role.Search";
            console.log("permissionName", vm.permissionName);
            console.log("roleId", vm.roleId);
            console.log("roleName", vm.roleName);
            console.log("selectedRolePermission", vm.selectedRolePermission);
            
            RoleService.SearchRole(vm.permissionName, tmpUserName, vm.roleId, vm.roleName, vm.selectedRolePermission, $scope.pagination.pageSize, $scope.pagination.pageNumber, $scope.sort,
                function (response) {
                    console.log("Success!");
                    $scope.gridOptions.data = response.data;
                    $scope.pagination.totalItems = 25;
                },
                function (response) {
                    AlertService.Add("Error", "Data not received.");
                    console.log("Error!");
                }
            );
            //vm.dataLoading = false;
            console.log("searchRole End");

        };


    }

})();
