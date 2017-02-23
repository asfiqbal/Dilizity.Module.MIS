(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('actionPasswordPolicyController', actionPasswordPolicyController);

    actionPasswordPolicyController.$inject = ['$uibModal', '$window', '$scope', '$stateParams', '$rootScope', 'AuthenticationService', 'Notification', 'HelperService', 'UniversalService', 'CommunicationService'];
    function actionPasswordPolicyController($uibModal, $window, $scope, $stateParams, $rootScope, AuthenticationService, Notification, HelperService, UniversalService, CommunicationService) {
        var vm = this;

        var roleId = -1;
        var makerId = -1;

        vm.title = '';
        vm.newMessage = '';


        vm.doAction = doAction;
        vm.isMakerCheckerMode = isMakerCheckerMode;
        vm.isMakerMode = isMakerMode;
        vm.isCheckerMode = isCheckerMode;

        vm.loadScreenPermissionsAndInfo = loadScreenPermissionsAndInfo;
        vm.roleName = '';
        vm.availablePermissions = {};
        vm.assignedPermissions = [];
        vm.userPermission = {};
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

            var sourceNode = HelperService.deepSearch(sourceModel, 'Id', sourceId);
            var targetNode = HelperService.deepSearch(targetModel, 'Id', targetId);

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
                        roleId = data.Data.Id;
                        vm.roleName = data.Data.Name;
                        vm.availablePermissions = data.Data.AvailablePermissions;
                        vm.assignedPermissions = data.Data.AssignedPermissions;
                        vm.userPermission = data.Data.UserPermission;
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
            console.log("actionPasswordPolicyController.initController -> Begin");
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
   
            console.log("actionPasswordPolicyController.initController -> End");
        })();

        function doAction(actionStats, additionalPermission, form) {
            console.log("doAction Begin");

            if (!validateForm(form)) {
                return false;
            }

            var tmpUserName = $rootScope.globals.currentUser.username;
            var actionPermission = vm.permissionName + additionalPermission;

            var model = CreateModel(actionStats);

            UniversalService.Do(actionPermission, tmpUserName, model,
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

            console.log("doAction End");
        }

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

        function validateForm(form) {
            console.log("form", form);
            console.log("form.$valid", form.$valid);
            console.log("vm.assignedPermissions.length", vm.assignedPermissions.length);

            if (!form.$valid) {
                if (!vm.roleName)  {
                    Notification.error({ message: 'Role Name is Required', positionY: 'bottom', positionX: 'right' });
                }
                if (vm.assignedPermissions.length < 2) {
                    Notification.error({ message: 'Permissions are not correctly defined', positionY: 'bottom', positionX: 'right' });
                }

                return false;
            }

            if (!form.$dirty) {
                Notification.error({ message: 'No change has been made', positionY: 'bottom', positionX: 'right' });
                return false;
            }
            return true;
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

        vm.compare = function (size, parentSelector) {
            var parentElem = parentSelector ?
              angular.element($document[0].querySelector('.x_panel' + parentSelector)) : undefined;

            var model = {
                RoleId: roleId,
                MakerId: makerId
            };

            var tmpUserName = $rootScope.globals.currentUser.username;
            var outHtml = '';

            var jsondiffpatch = $window.jsondiffpatch;
            var jsonDiff = jsondiffpatch.create({
                objectHash: function (obj) {
                    if (typeof obj._id !== 'undefined') {
                        return obj._id;
                    }
                    if (typeof obj.id !== 'undefined') {
                        return obj._id;
                    }
                    if (typeof obj.name !== 'undefined') {
                        return obj.name;
                    }
                    return JSON.stringify(obj);
                },
                arrays: {
                    detectMove: true,
                    includeValueOnMove: false
                },
                textDiff: {
                    minLength: 60
                }
            });

            UniversalService.Do(vm.permissionName + '.Compare', tmpUserName, model,
               function (response) {
                   var data = angular.fromJson(response.data);

                   if (data.ErrorCode == 0) {
                       console.log("Success!");
                       var delta = jsondiffpatch.diff(data.Data.Old, data.Data.New);
                       outHtml = jsondiffpatch.formatters.html.format(delta, data.Data.Old);
                       CommunicationService.Set('COMPARE', outHtml);
                       //console.log('outHtml', outHtml);

                       var modalInstance = $uibModal.open({
                           animation: true,
                           ariaLabelledBy: 'modal-title',
                           ariaDescribedBy: 'modal-body',
                           templateUrl: 'app/templates/compareJSON.html',
                           controller: 'compareJSONController',
                           controllerAs: 'vm',
                           windowClass: 'zindex',
                           size: size,
                           appendTo: parentElem,
                           resolve: {
                               beautyHtml: function () {
                                   return outHtml;
                               }
                           }
                       });
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



        }
    }

})();
