/// <reference path="../maker/dilizityBackofficeMakerService.js" />

(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('actionRoleController', actionRoleController);

    actionRoleController.$inject = ['$scope', '$stateParams', '$rootScope', 'AuthenticationService', 'RoleService', 'Notification', 'HelperService', 'dilizityBackofficeMakerService', 'dilizityBackofficeCheckerService','UniversalService'];
    function actionRoleController($scope, $stateParams, $rootScope, AuthenticationService, RoleService, Notification, HelperService, dilizityBackofficeMakerService, dilizityBackofficeCheckerService, UniversalService) {
        var vm = this;

        var roleId = -1;
        var makerId = -1;

        vm.title = '';
        vm.newMessage = '';

        vm.saveAsDraft = saveAsDraft;
        vm.checkerApprovalReady = checkerApprovalReady;
        vm.add = add;
        vm.update = update;
        vm.approve = approve;
        vm.correctionRequired = correctionRequired;
        vm.reject = reject;
        vm.isMakerCheckerMode = isMakerCheckerMode;
        vm.isMakerMode = isMakerMode;
        vm.isCheckerMode = isCheckerMode;

        vm.loadScreenPermissionsAndInfo = loadScreenPermissionsAndInfo;
        vm.roleName = '';
        vm.availablePermissions = {};
        vm.assignedPermissions = [];
        vm.notes = [];

        vm.permissionName = '';

        vm.deleteTreeItem = function (tree, id) {
            for (var i = 0; i < tree.length; i++) {
                if (tree[i].Id == id) {
                    tree.splice(i, 1);
                    i = 0;
                } else {
                    if (tree[i].children.length > 0) {
                        tree[i].children = vm.deleteTreeItem(tree[i].children, id);
                    }
                }
            }
            return tree;
        }

        vm.movePermissions = function (sourceTree, targetTree, sourceModel, targetModel) {
            console.log('movePermissions Begin');

            var sourceId = sourceTree.currentNode.Id;
            var targetId = targetTree.currentNode.Id;

            //console.log('sourceId', sourceId);
            //console.log('targetId', targetId);

            var sourceNode = HelperService.deepSearch(sourceModel, 'Id', sourceId);
            var targetNode = HelperService.deepSearch(targetModel, 'Id', targetId);
            //console.log('sourceNode', sourceNode);
            //console.log('targetNode', targetNode);

            vm.deleteTreeItem(sourceModel, sourceId);
            targetNode.children.push(angular.copy(sourceNode));
            console.log('movePermissions End');
        }

        vm.copyPermissions = function (sourceTree, targetTree, sourceModel, targetModel) {
            console.log('copyPermissions Begin');

            var sourceId = sourceTree.currentNode.Id;
            var targetId = targetTree.currentNode.Id;

            //console.log('sourceId', sourceId);
            //console.log('targetId', targetId);

            var sourceNode = HelperService.deepSearch(sourceModel, 'Id', sourceId);
            var targetNode = HelperService.deepSearch(targetModel, 'Id', targetId);
            //console.log('sourceNode', sourceNode);
            //console.log('targetNode', targetNode);

            targetNode.children.push(angular.copy(sourceNode));
            console.log('copyPermissions End');
        }

        vm.RemovePermissions = function (targetTree, targetModel) {
            console.log('RemovePermissions Begin');

            var targetId = targetTree.currentNode.Id;

            //console.log('sourceId', sourceId);
            //console.log('targetId', targetId);

            var targetNode = HelperService.deepSearch(targetModel, 'Id', targetId);
            //console.log('sourceNode', sourceNode);
            //console.log('targetNode', targetNode);

            vm.deleteTreeItem(targetModel, targetId);
            console.log('RemovePermissions End');
        }

        function loadScreenPermissionsAndInfo() {
            console.log("loadScreenPermissionsAndInfo Begin");
            var tmpUserName = $rootScope.globals.currentUser.username;


            var model = {
                RoleId: roleId,
                MakerId: makerId
            }

            UniversalService.Do(vm.permissionName, tmpUserName, model,
                function (response) {
                    console.log("Success!");
                    var data = angular.fromJson(response.data);

                    if (response.data.ErrorCode == 0) {
                        vm.roleId = data.Data.Id;
                        vm.roleName = data.Data.Name;
                        vm.availablePermissions = data.Data.AvailablePermissions;
                        vm.assignedPermissions = data.Data.AssignedPermissions;
                        vm.notes = data.Data.Notes;
                    }
                    else {
                        Notification.error({ message: response.data.ErrorMessage, positionY: 'bottom', positionX: 'right' });
                    }
                },
                function (response) {
                    console.log("response!", response);
                    Notification.error({ message: response.statusText, positionY: 'bottom', positionX: 'right' });
                }
            );

            console.log("loadScreenPermissionsAndInfo End");
        };

        (function initController() {
            console.log("actionRoleController.initController -> Begin");
            console.log("$stateParams.roleId", $stateParams.roleId);
            console.log("$stateParams.permissionName", $stateParams.permissionName);

            roleId = parseInt($stateParams.roleId);
            if (!HelperService.IsNumber(roleId)) {
                roleId = 0;
            }
            console.log("roleId", roleId);

            vm.permissionName = $stateParams.permissionName;
            makerId = parseInt($stateParams.makerId);
            console.log("makerId", makerId);
            if (!HelperService.IsNumber(makerId)) {
                makerId = 0;
            }
            console.log("makerId", makerId);

            var arr = vm.permissionName.split(".");
            vm.title = arr[arr.length - 1] + ' Role';
            console.log("vm.title", vm.title);


            loadScreenPermissionsAndInfo();
   
            console.log("actionRoleController.initController -> End");
        })();

        function saveAsDraft(makerStatus) {
            console.log("saveAsDraft Begin");
            //vm.dataLoading = true;
            var tmpUserName = $rootScope.globals.currentUser.username;
            var model = CreateModel(makerStatus);

            var savePermission = vm.permissionName + '.Save';

            //dilizityBackofficeMakerService.SaveAsDraft(savePermission, tmpUserName, model, function (response) {
            //    console.log("Success!");
            //    Notification.success({ message: "Role Added Successfully.", positionY: 'bottom', positionX: 'right' });
            //}, function (response) {
            //    Notification.error({ message: response.statusText, positionY: 'bottom', positionX: 'right' });
            //});

            console.log("savePermission", savePermission);


            UniversalService.Do(savePermission, tmpUserName, model,
                function (response) {
                    console.log("Success!");
                    var data = angular.fromJson(response.data);

                    if (data.ErrorCode == 0) {
                        Notification.success({ message: data.ErrorMessage, positionY: 'bottom', positionX: 'right' });
                    }
                    else {
                        Notification.error({ message: data.ErrorMessage, positionY: 'bottom', positionX: 'right' });
                    }
                },
                function (response) {
                    console.log("response!", response);
                    Notification.error({ message: response.statusText, positionY: 'bottom', positionX: 'right' });
                }
            );



            console.log("saveAsDraft End");
        };

        function checkerApprovalReady(makerStatus) {
            console.log("checkerApprovalReady Begin");
            //vm.dataLoading = true;
            var tmpUserName = $rootScope.globals.currentUser.username;
            var savePermission = vm.permissionName + '.ApprovalReady';

            var model = CreateModel(makerStatus);

            //dilizityBackofficeMakerService.CheckerApprovalReady(vm.permissionName, tmpUserName, model, function (response) {
            //    console.log("Success!");
            //    Notification.success({ message: "Role Added Successfully.", positionY: 'bottom', positionX: 'right' });
            //}, function (response) {
            //    Notification.error({ message: response.statusText, positionY: 'bottom', positionX: 'right' });
            //});

            UniversalService.Do(savePermission, tmpUserName, model,
                function (response) {
                    console.log("Success!");
                    var data = angular.fromJson(response.data);

                    if (data.ErrorCode == 0) {
                        Notification.success({ message: data.ErrorMessage, positionY: 'bottom', positionX: 'right' });
                    }
                    else {
                        Notification.error({ message: data.ErrorMessage, positionY: 'bottom', positionX: 'right' });
                    }
                },
                function (response) {
                    console.log("response!", response);
                    Notification.error({ message: response.statusText, positionY: 'bottom', positionX: 'right' });
                }
            );

            console.log("checkerApprovalReady End");
        };

        function correctionRequired(makerStatus) {
            console.log("correctionRequired Begin");
            //vm.dataLoading = true;
            var tmpUserName = $rootScope.globals.currentUser.username;
            var model = CreateModel(makerStatus);

            dilizityBackofficeCheckerService.CorrectionRequired(vm.permissionName, tmpUserName, model, function (response) {
                console.log("Success!");
                Notification.success({ message: "Role Added Successfully.", positionY: 'bottom', positionX: 'right' });
            }, function (response) {
                Notification.error({ message: response.statusText, positionY: 'bottom', positionX: 'right' });
            });
            
            console.log("correctionRequired End");
        };

        function reject() {
            console.log("reject Begin");
            //vm.dataLoading = true;
            var tmpUserName = $rootScope.globals.currentUser.username;
            var model = CreateModel("Rejected");

            dilizityBackofficeCheckerService.Reject(vm.permissionName, tmpUserName, model, function (response) {
                console.log("Success!");
                Notification.success({ message: "Role Added Successfully.", positionY: 'bottom', positionX: 'right' });
            }, function (response) {
                Notification.error({ message: response.statusText, positionY: 'bottom', positionX: 'right' });
            });

            console.log("reject End");
        };

        function approve() {
            console.log("approve Begin");
            //vm.dataLoading = true;
            var tmpUserName = $rootScope.globals.currentUser.username;
            var model = CreateModel('Approved');
            dilizityBackofficeCheckerService.Approve(vm.permissionName, tmpUserName, model, function (response) {
                console.log("Success!");
                Notification.success({ message: "Role Added Successfully.", positionY: 'bottom', positionX: 'right' });
            }, function (response) {
                Notification.error({ message: response.statusText, positionY: 'bottom', positionX: 'right' });
            });

            console.log("approve End");
        };

        function add() {
            console.log("add Begin");
            //vm.dataLoading = true;
            var tmpUserName = $rootScope.globals.currentUser.username;
            var model = CreateModel(null);

            console.log(model);

            RoleService.Add(vm.permissionName, tmpUserName, model, function (response) {
                console.log("Success!");
                Notification.success({ message: "Role Added Successfully.", positionY: 'bottom', positionX: 'right' });
            }, function (response) {
                Notification.error({ message: response.statusText, positionY: 'bottom', positionX: 'right' });
            });

            console.log("add End");
        };

        function update() {
            console.log("update Begin");
            //vm.dataLoading = true;
            var tmpUserName = $rootScope.globals.currentUser.username;
            var model = CreateModel(null);

            console.log(model);

            RoleService.Update(vm.permissionName, tmpUserName, model, function (response) {
                console.log("Success!");
                Notification.success({ message: "Role Added Successfully.", positionY: 'bottom', positionX: 'right' });
            }, function (response) {
                Notification.error({ message: response.statusText, positionY: 'bottom', positionX: 'right' });
            });

            console.log("update End");
        };

        function CreateModel(makerStatus) {
            console.log("CreateModel Begin");
            //vm.dataLoading = true;
            var tmpUserName = $rootScope.globals.currentUser.username;
            var model = {};

            if (isMakerCheckerMode()) {
                model = {
                    "Id": roleId,
                    "MakerId": makerId,
                    "Name": vm.roleName,
                    "Status": makerStatus,
                    "AvailablePermissions": vm.availablePermissions,
                    "AssignedPermissions": vm.assignedPermissions,
                    "Notes": vm.notes
                };
            }
            else {

                model = {
                    "Id": roleId,
                    "Name": vm.roleName,
                    "AvailablePermissions": vm.availablePermissions,
                    "AssignedPermissions": vm.assignedPermissions
                };
            }

            console.log("model", model);


            return model;
            console.log("CreateModel End");
        };

        function isMakerCheckerMode() {
            return HelperService.containsAny(vm.permissionName, ['Maker', 'Checker'])
        };

        function isMakerMode() {
            return HelperService.containsAny(vm.permissionName, ['Maker'])
        };

        function isCheckerMode() {
            return HelperService.containsAny(vm.permissionName, ['Checker'])
        };

        vm.saveNote = function saveNote() {
            console.log("saveNote Begin");

            console.log("vm.notes", vm.notes);
            console.log("vm.newMessage", vm.newMessage);

            if (!vm.notes) {
                vm.notes = new Array();
            }

            console.log("vm.notes", vm.notes);

            vm.notes.push(vm.newMessage);
            vm.newMessage = '';

            console.log("saveNote End");
        };

    }

})();
