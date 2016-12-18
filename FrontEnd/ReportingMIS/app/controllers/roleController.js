
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

        $scope.gridOptions = {
            enableGridMenu: true,
            enableSelectAll: true,
            data:[],
            exporterCsvFilename: 'myFile.csv',
            onRegisterApi: function (gridApi) {
                $scope.gridApi = gridApi;
            }
        };


        (function initController() {
            console.log("roleController.initController -> Begin");
            
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
            vm.permissionName = "Dilizity.Backoffice.Role";
            console.log("permissionName", vm.permissionName);
            console.log("roleId", vm.roleId);
            console.log("roleName", vm.roleName);

            RoleService.SearchRole(vm.permissionName, tmpUserName, vm.roleId, vm.roleName,
                function (response) {
                $scope.gridOptions.data = response.data;
                console.log("Success!");
                AlertService.Add("warning", "This is a warning.");
                },
                function (response) {
                    console.log("Error!");
                }
            );
            //vm.dataLoading = false;
            console.log("searchRole End");

        };
    }

})();
