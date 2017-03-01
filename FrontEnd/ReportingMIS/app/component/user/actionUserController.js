(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('actionUserController', actionUserController);

    actionUserController.$inject = ['$uibModal', '$window', '$scope', '$stateParams', '$rootScope', 'AuthenticationService', 'Notification', 'HelperService', 'UniversalService', 'CommunicationService'];
    function actionUserController($uibModal, $window, $scope, $stateParams, $rootScope, AuthenticationService, Notification, HelperService, UniversalService, CommunicationService) {
        var vm = this;

        var id = -1;
        var makerId = -1;

        vm.myImage = '';
        vm.myCroppedImage = '';
        vm.loginId = '';
        vm.email = '';
        vm.mobilenumber = '';
        vm.passwordAttempts = 0;
        vm.selectedPasswordPolicy = 0;
        vm.selectedManger = 0;
        vm.selectedDepartment = 0;
        vm.accountLocked = 0;
        vm.name = '';
        vm.availableRoles = {};
        vm.assignedRoles = [];
        vm.passwordPolicy = [];
        vm.departments = [];
        vm.userPermission = {};
        vm.departments = [];
        vm.notes = [];

        vm.permissionName = '';

        vm.title = '';
        vm.newMessage = '';
        vm.managerList = [];
        vm.selectConfigManager = {
            maxItems: 1,
            optgroupField: 'Department',
            valueField: 'Id',
            labelField: 'Name',
            searchField: ['Name'],
            render: {
                optgroup_header: function (data, escape) {
                    return '<div class="optgroup-header">' + escape(data.label) + ' <span class="scientific">' + escape(data.label_scientific) + '</span></div>';
                }
            },
            optgroups: [
                { value: 'PIT', label: 'PIT', label_scientific: 'PIT' },
                { value: 'Support', label: 'Support', label_scientific: 'Support' },
                { value: 'Operations', label: 'Operations', label_scientific: 'Operations' }
            ]
        };
        vm.selectConfigRoles = {
            create: true,
            valueField: 'Id',
            labelField: 'Name',
            onChange: function (value) {
                console.log('onChange', value)
            }
            // maxItems: 1,
            // required: true,
        }

        vm.doAction = doAction;
        vm.isMakerCheckerMode = isMakerCheckerMode;
        vm.isMakerMode = isMakerMode;
        vm.isCheckerMode = isCheckerMode;

        vm.loadScreenPermissionsAndInfo = loadScreenPermissionsAndInfo;


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

        var handleFileSelect = function (evt) {
            var file = evt.currentTarget.files[0];
            var reader = new FileReader();
            reader.onload = function (evt) {
                $scope.$apply(function ($scope) {
                    vm.myImage = evt.target.result;
                });
            };
            reader.readAsDataURL(file);
        };

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
                Id: id,
                MakerId: makerId
            }

            UniversalService.Do(vm.permissionName, tmpUserName, model,
                function (response) {
                    console.log("Success!");
                    var data = angular.fromJson(response.data);

                    if (response.data.ErrorCode == 0) {
                        id = data.Data.Id;
                        vm.name = data.Data.Name;
                        vm.email = data.Data.Email;
                        vm.mobilenumber = data.Data.MobileNumber;
                        vm.myCroppedImage = data.Data.Picture;
                        vm.passwordAttempts = data.Data.PasswordAttempts;
                        vm.accountLocked = data.Data.AccountLocked;
                        vm.selectedPasswordPolicy = data.Data.PasswordPolicyId;
                        vm.selectedManger = data.Data.ManagerId;
                        vm.selectedDepartment = data.Data.DepartmentId;
                        vm.selectedRoles = data.Data.AssignedRoles;
                        vm.passwordPolicy = data.Data.PasswordPolicies;
                        vm.managerList = data.Data.Managers;
                        vm.departments = data.Data.Departments;
                        vm.availableRoles = data.Data.Roles;
                        vm.assignedRoles = data.Data.AssignedRoles;
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
            console.log("actionUserController.initController -> Begin");
            console.log("$stateParams.id", $stateParams.id);
            console.log("$stateParams.permissionName", $stateParams.permissionName);

            id = parseInt($stateParams.id);
            if (!HelperService.IsNumber(id)) {
                id = 0;
            }
            console.log("id", id);

            vm.permissionName = $stateParams.permissionName;
            makerId = parseInt($stateParams.makerId);
            console.log("makerId", makerId);
            if (!HelperService.IsNumber(makerId)) {
                makerId = 0;
            }
            console.log("makerId", makerId);

            var arr = vm.permissionName.split(".");
            vm.title = arr[arr.length - 1] + ' User';
            console.log("vm.title", vm.title);


            loadScreenPermissionsAndInfo();

            angular.element(document.querySelector('#fileInput')).on('change', handleFileSelect);

            console.log("actionUserController.initController -> End");
        })();

        function doAction(actionStats, additionalPermission, form) {
            console.log("doAction Begin");

            if (!validateForm(form)) {
                return false;
            }

            var tmpUserName = $rootScope.globals.currentUser.username;
            var actionPermission = vm.permissionName + additionalPermission;

            var model = CreateModel(actionStats);

            console.log("model", model);

            
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
                    "Id": id,
                    "MakerId": makerId,
                    "Name": vm.name,
                    "Status": makerStatus,
                    "LoginId": vm.loginId,
                    "Email": vm.email,
                    "MobileNumber": vm.mobilenumber,
                    "PasswordAttempts": vm.passwordAttempts,
                    "SelectedPasswordPolicy": vm.selectedPasswordPolicy,
                    "AccountLocked": vm.accountLocked,
                    "SelectedManager": vm.selectedManger,
                    "SelectedDepartment": vm.selectedDepartment,
                    "AssignedRoles": vm.assignedRoles,
                    "Picture": vm.myCroppedImage,
                    "Notes": vm.notes
                };
            }
            else {

                model = {
                    "Id": id,
                    "Name": vm.name,
                    "LoginId": vm.loginId,
                    "Email": vm.email,
                    "MobileNumber": vm.mobilenumber,
                    "PasswordAttempts": vm.passwordAttempts,
                    "SelectedPasswordPolicy": vm.selectedPasswordPolicy,
                    "SelectedPasswordPolicy": vm.accountLocked,
                    "AccountLocked": vm.accountLocked,
                    "SelectedManager": vm.selectedManger,
                    "SelectedDepartment":vm.selectedDepartment,
                    "AssignedRoles": vm.assignedRoles,
                    "Picture": vm.myCroppedImage
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
            console.log("vm.assignedRoles.length", vm.assignedRoles.length);

            if (!form.$valid) {
                if (!vm.name)  {
                    Notification.error({ message: 'User Name is Required', positionY: 'bottom', positionX: 'right' });
                }
                if (vm.assignedRoles.length < 1) {
                    Notification.error({ message: 'Roles are not correctly assigned', positionY: 'bottom', positionX: 'right' });
                }
                if (!vm.email) {
                    Notification.error({ message: 'Email is required', positionY: 'bottom', positionX: 'right' });
                }
                if (!vm.mobilenumber) {
                    Notification.error({ message: 'Mobile Number is required', positionY: 'bottom', positionX: 'right' });
                }
                if (vm.passwordAttempts < 1) {
                    Notification.error({ message: 'Password Attempts is required', positionY: 'bottom', positionX: 'right' });
                }
                if (vm.selectedPasswordPolicy < 1) {
                    Notification.error({ message: 'Password Policy is required', positionY: 'bottom', positionX: 'right' });
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
                id: id,
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
