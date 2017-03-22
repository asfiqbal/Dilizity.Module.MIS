
(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('searchUserController', searchUserController);

    searchUserController.$inject = ['$scope', '$stateParams', '$rootScope', 'AuthenticationService', 'UniversalService', 'Notification', 'HelperService'];
    function searchUserController($scope, $stateParams, $rootScope, AuthenticationService, UniversalService, Notification, HelperService) {
        var vm = this;

        vm.slide = false;
        vm.searchUser = searchUser;
        vm.loadScreenPermissionsAndInfo = loadScreenPermissionsAndInfo;
        vm.load = load;
        vm.deleteUsers = deleteUsers;
        vm.resetPasswords = resetPasswords;
        vm.blockUsers = blockUsers;
        vm.unBlockUsers = unBlockUsers;
        vm.isMakerDelete = isMakerDelete;

        vm.userId = '';
        vm.userName = '';
        vm.loginId = '';
        vm.mobileNumber = '';
        vm.email = '';
        vm.permissionId = '';
        vm.userPermission = {};
        vm.roleList = [];
        vm.selectedRole = -1;
        vm.selectedUsers = [];
        vm.selectedDialogButton = '';

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
              {name:'User Id',field:'UserId'},
              {name:'User Name',field:'UserName'},
              { name: 'Login Id', field: 'LoginId' },
              { name: 'Mobile Number', field: 'MobileNumber' },
              { name: 'Email', field: 'Email' },
              { name: 'Account Locked', field: 'AccountLocked' },
              { name: 'Updated By', field: 'UpdatedBy' },
              { name: 'Updated On', field: 'UpdatedOn' },
              { name: 'Action', cellTemplate: '<div>'+
                                                '<ul class="nav navbar-right panel_toolbox">'+
	                                                '<li>'+
                                                		'<a ng-show="grid.appScope.vm.userPermission.View===\'Dilizity.Backoffice.User.View\'" uib-tooltip="View User" tooltip-placement="left" ui-sref="index.ActionUser({ id: row.entity.UserId, makerId: 0, permissionName: \'Dilizity.Backoffice.User.View\' })" class="pull-right"><i class="fa fa-eye"></i></a>' +
	                                                '</li>'+
	                                                '<li>'+
		                                                '<a ng-show="grid.appScope.vm.userPermission.Edit===\'Dilizity.Backoffice.User.Edit\'" uib-tooltip="Edit User" tooltip-placement="left" ui-sref="index.ActionUser({ id: row.entity.UserId, makerId: 0, permissionName: \'Dilizity.Backoffice.User.Edit\' })" class="pull-right"><i class="fa fa-pencil-square"></i></a>' +
		                                                '<a ng-show="grid.appScope.vm.userPermission.Edit===\'Dilizity.Backoffice.User.Edit.Maker\'" uib-tooltip="Edit User [Maker]" tooltip-placement="left" ui-sref="index.ActionUser({ id: row.entity.UserId, makerId: 0, permissionName: \'Dilizity.Backoffice.User.Edit.Maker\' })" class="pull-right"><i class="fa fa-pencil-square"></i></a>' +
	                                                '<li>' +
	                                                '<li>' +
		                                                '<a ng-show="grid.appScope.vm.userPermission.Delete===\'Dilizity.Backoffice.User.Delete\'" uib-tooltip="Delete User" tooltip-placement="left" ui-sref="index.ActionUser({ id: row.entity.UserId, makerId: 0, permissionName: \'Dilizity.Backoffice.User.Delete\' })" class="pull-right"><i class="fa fa-trash"></i></a>' +
		                                                '<a ng-show="grid.appScope.vm.userPermission.Delete===\'Dilizity.Backoffice.User.Delete.Maker\'" uib-tooltip="Delete User [Maker]" tooltip-placement="left" ui-sref="index.ActionUser({ id: row.entity.UserId, makerId: 0, permissionName: \'Dilizity.Backoffice.User.Delete.Maker\' })" class="pull-right"><i class="fa fa-trash"></i></a>' +
	                                                '<li>' +
                                                '</ul>' +
                                               '</div>' }
            ],
            data:[],
            exporterCsvFilename: 'Users.csv',
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
                    vm.selectedUsers.push(row.entity.UserId);
                }
                else {
                    var pos = vm.selectedUsers.indexOf(row.entity.UserId);
                    vm.selectedUsers.splice(pos, 1);
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
                          console.log("vm.userPermission.ResetPasswordBulk", vm.userPermission.ResetPasswordBulk);
                          
                          vm.roleList = data.Data.RoleList;
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

        function searchUser() {
            console.log("searchUser Begin");
            var tmpUserName = $rootScope.globals.currentUser.username;
            var searchPermissionId = vm.permissionId + ".Search";

            var model = {
                UserId: vm.userId,
                UserName: vm.userName,
                RoleId: vm.selectedRole,
                LoginId: vm.loginId,
                MobileNumber: vm.mobileNumber,
                Email: vm.email,
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

        function deleteUsers() {
            console.log("deleteUsers Begin");
            angular.element('#modal').modal('hide');
            var tmpUserName = $rootScope.globals.currentUser.username;
            //Notification.error({ message: 'Error Bottom Right', positionY: 'bottom', positionX: 'right' });
            var deletePermission = vm.permissionId + ".Delete.Bulk";
            console.log("permissionId", deletePermission);
            console.log("vm.selectedUsers", vm.selectedUsers);

            var model = {
                Users: vm.selectedUsers
            }

            UniversalService.Do(deletePermission, tmpUserName, model,
                function (response) {
                    console.log("Success!");
                    var data = angular.fromJson(response.data);

                    if (data.ErrorCode == 0) {
                        Notification.success({ message: data.ErrorMessage, positionY: 'bottom', positionX: 'right' });
                        vm.selectedUsers = [];
                        searchUser();
                    }
                    else {
                        Notification.error({ message: data.ErrorMessage, positionY: 'bottom', positionX: 'right' });
                        vm.selectedUsers = [];
                    }
                },
                function (response) {
                    console.log("response!", response);
                    Notification.error({ message: response.statusText, positionY: 'bottom', positionX: 'right' });
                }
            );
            console.log("deleteUsers End");

        };

        function resetPasswords() {
            console.log("resetPasswords Begin");
            angular.element('#modal').modal('hide');
            var tmpUserName = $rootScope.globals.currentUser.username;
            //Notification.error({ message: 'Error Bottom Right', positionY: 'bottom', positionX: 'right' });
            var resetPermission = vm.permissionId + ".ResetPasswordBulk";
            console.log("permissionId", resetPermission);
            console.log("vm.selectedUsers", vm.selectedUsers);

            var model = {
                Users: vm.selectedUsers
            }

            UniversalService.Do(resetPermission, tmpUserName, model,
                function (response) {
                    console.log("Success!");
                    var data = angular.fromJson(response.data);

                    if (data.ErrorCode == 0) {
                        Notification.success({ message: data.ErrorMessage, positionY: 'bottom', positionX: 'right' });
                        vm.selectedUsers = [];
                        searchUser();
                    }
                    else {
                        Notification.error({ message: data.ErrorMessage, positionY: 'bottom', positionX: 'right' });
                        vm.selectedUsers = [];
                    }
                },
                function (response) {
                    console.log("response!", response);
                    Notification.error({ message: response.statusText, positionY: 'bottom', positionX: 'right' });
                }
            );
            console.log("resetPasswords End");

        };

        function blockUsers() {
            console.log("blockUser Begin");
            angular.element('#modal').modal('hide');
            var tmpUserName = $rootScope.globals.currentUser.username;
            //Notification.error({ message: 'Error Bottom Right', positionY: 'bottom', positionX: 'right' });
            var resetPermission = vm.permissionId + ".BlockAccountBulk";
            console.log("permissionId", resetPermission);
            console.log("vm.selectedUsers", vm.selectedUsers);

            var model = {
                Users: vm.selectedUsers
            }

            UniversalService.Do(resetPermission, tmpUserName, model,
                function (response) {
                    console.log("Success!");
                    var data = angular.fromJson(response.data);

                    if (data.ErrorCode == 0) {
                        Notification.success({ message: data.ErrorMessage, positionY: 'bottom', positionX: 'right' });
                        vm.selectedUsers = [];
                        searchUser();
                    }
                    else {
                        Notification.error({ message: data.ErrorMessage, positionY: 'bottom', positionX: 'right' });
                        vm.selectedUsers = [];
                    }
                },
                function (response) {
                    console.log("response!", response);
                    Notification.error({ message: response.statusText, positionY: 'bottom', positionX: 'right' });
                }
            );
            console.log("blockUser End");

        };

        function unBlockUsers() {
            console.log("unBlockUser Begin");
            angular.element('#modal').modal('hide');
            var tmpUserName = $rootScope.globals.currentUser.username;
            //Notification.error({ message: 'Error Bottom Right', positionY: 'bottom', positionX: 'right' });
            var resetPermission = vm.permissionId + ".UnblockAccountBulk";
            console.log("permissionId", resetPermission);
            console.log("vm.selectedUsers", vm.selectedUsers);

            var model = {
                Users: vm.selectedUsers
            }

            UniversalService.Do(resetPermission, tmpUserName, model,
                function (response) {
                    console.log("Success!");
                    var data = angular.fromJson(response.data);

                    if (data.ErrorCode == 0) {
                        Notification.success({ message: data.ErrorMessage, positionY: 'bottom', positionX: 'right' });
                        vm.selectedUsers = [];
                        searchUser();
                    }
                    else {
                        Notification.error({ message: data.ErrorMessage, positionY: 'bottom', positionX: 'right' });
                        vm.selectedUsers = [];
                    }
                },
                function (response) {
                    console.log("response!", response);
                    Notification.error({ message: response.statusText, positionY: 'bottom', positionX: 'right' });
                }
            );
            console.log("unBlockUser End");

        };

        function isMakerDelete() {
            console.log("isMakerDelete Begin");
            return HelperService.containsAny(vm.userPermission, ['Maker', 'Delete'])
        };


    }

})();
