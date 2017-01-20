﻿
(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('actionRoleController', actionRoleController);

    actionRoleController.$inject = ['$scope', '$filter', '$stateParams', '$rootScope', 'AuthenticationService', 'RoleService', 'AlertService', 'HelperService'];
    function actionRoleController($scope, $filter, $stateParams, $rootScope, AuthenticationService, RoleService, AlertService, HelperService) {
        var vm = this;

        var roleId = -1;

        vm.title = '';

        vm.addRole = addRole;
        vm.loadScreenPermissionsAndInfo = loadScreenPermissionsAndInfo;
        vm.roleName = '';
        vm.availablePermissions = {};
        vm.assignedPermissions = [];
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
            RoleService.GetActionRoleScreenInfo(vm.permissionName, tmpUserName, roleId, function (response) {
                var data = angular.fromJson(response.data);
                vm.availablePermissions = data.AvailablePermissions;
                vm.assignedPermissions = data.AssignedPermissions;
                console.log("data", data);
            }, function (response) {
                Notification.error({ message: "You don't have permission", positionY: 'bottom', positionX: 'right' });
            });
            console.log("loadScreenPermissionsAndInfo End");
        };


        (function initController() {
            console.log("actionRoleController.initController -> Begin");
            console.log("$stateParams.roleId", $stateParams.roleId);
            console.log("$stateParams.permissionName", $stateParams.permissionName);

            roleId = $stateParams.roleId;
            vm.permissionName = $stateParams.permissionName;
            var arr = vm.permissionName.split(".");
            vm.title = arr[arr.length - 1] + ' Role';
            console.log("vm.title", vm.title);
            //console.log("permissionName", vm.permissionName);

            loadScreenPermissionsAndInfo();
   
            console.log("actionRoleController.initController -> End");
        })();

        function addRole() {
            console.log("addRole Begin");
            //vm.dataLoading = true;
            var tmpUserName = $rootScope.globals.currentUser.username;
            var model =
                     {
                         "Id": roleId,
                         "Name": vm.roleName,
                         "AssignedPermissions": vm.assignedPermissions
                     };
            RoleService.AddRole(permissionName, tmpUserName, model, "SaveAsDraft", function (response) {
                console.log("Success!");
                Notification.success({ message: "Role Added Successfully.", positionY: 'bottom', positionX: 'right' });
            }, function (response) {
                Notification.error({ message: response.statusText, positionY: 'bottom', positionX: 'right' });
            });
            console.log("addRole End");
        };
    }

})();
