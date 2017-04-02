(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('actionPasswordPolicyController', actionPasswordPolicyController);

    actionPasswordPolicyController.$inject = ['$uibModal', '$window', '$scope', '$stateParams', '$rootScope', 'AuthenticationService', 'Notification', 'HelperService', 'UniversalService', 'CommunicationService'];
    function actionPasswordPolicyController($uibModal, $window, $scope, $stateParams, $rootScope, AuthenticationService, Notification, HelperService, UniversalService, CommunicationService) {
        var vm = this;

        var id = -1;
        var makerId = -1;

        vm.permissionName = '';
        vm.title = '';
        vm.newMessage = '';
        vm.doAction = doAction;
        vm.isMakerCheckerMode = isMakerCheckerMode;
        vm.isMakerMode = isMakerMode;
        vm.isCheckerMode = isCheckerMode;

        vm.loadScreenPermissionsAndInfo = loadScreenPermissionsAndInfo;
        vm.name = '';
        vm.lengthRule = 0;
        vm.expiryRule = 0;
        vm.complexityRule = 0;
        vm.passwordCantReuse = 0;
        vm.firstLoginChangePassword = 0;
        vm.failedPasswordAttempts = 0;
        vm.accountLockOnFailedAttempts = 0;
        vm.twoFA = 0;
        vm.captchEnable = 0;
        vm.sso = 0;
        vm.notes = [];
        vm.userPermission = {};


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
                        vm.lengthRule = data.Data.LengthRule;
                        vm.expiryRule = data.Data.ExpiryRule;
                        vm.complexityRule = data.Data.ComplexityRule;
                        vm.passwordCantReuse = data.Data.NumberCantReuse;
                        vm.firstLoginChangePassword = !!+data.Data.FirstLoginChangePassword;
                        vm.failedPasswordAttempts = data.Data.DefaultPasswordAttempts;
                        vm.accountLockOnFailedAttempts = !!+data.Data.AccountLockOnFailedAttempts;
                        vm.twoFA = !!+data.Data.Is2FAEnabled;
                        vm.captchEnable = !!+data.Data.IsCaptchEnabled;
                        vm.sso = !!+data.Data.SingleSignon;
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
            vm.title = arr[arr.length - 1] + ' Password Policy';
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
            vm.name = data.Data.Name;
            vm.lengthRule = data.Data.LengthRule;
            vm.expiryRule = data.Data.ExpiryRule;
            vm.complexityRule = data.Data.ComplexityRule;
            vm.passwordCantReuse = data.Data.NumberCantReuse;
            vm.firstLoginChangePassword = !!+data.Data.FirstLoginChangePassword;
            vm.failedPasswordAttempts = data.Data.DefaultPasswordAttempts;
            vm.accountLockOnFailedAttempts = !!+data.Data.AccountLockOnFailedAttempts;
            vm.twoFA = !!+data.Data.Is2FAEnabled;
            vm.captchEnable = !!+data.Data.IsCaptchEnabled;
            vm.sso = !!+data.Data.SingleSignon;


            if (isMakerCheckerMode()) {
                model = {
                    "Id": id,
                    "MakerId": makerId,
                    "Name": vm.name,
                    "LengthRule": vm.lengthRule,
                    "ExpiryRule": vm.expiryRule,
                    "ComplexityRule": vm.complexityRule,
                    "PasswordCantReuse": vm.passwordCantReuse,
                    "FirstLoginChangePassword": vm.firstLoginChangePassword,
                    "FailedPasswordAttempts": vm.failedPasswordAttempts,
                    "AccountLockOnFailedAttempts": vm.accountLockOnFailedAttempts,
                    "TwoFA": vm.twoFA,
                    "CaptchEnable": vm.captchEnable,
                    "SSO": vm.sso,
                    "Notes": vm.notes
                };
            }
            else {

                model = {
                    "Id": id,
                    "Name": vm.name,
                    "LengthRule": vm.lengthRule,
                    "ExpiryRule": vm.expiryRule,
                    "ComplexityRule": vm.complexityRule,
                    "PasswordCantReuse": vm.passwordCantReuse,
                    "FirstLoginChangePassword": vm.firstLoginChangePassword,
                    "FailedPasswordAttempts": vm.failedPasswordAttempts,
                    "AccountLockOnFailedAttempts": vm.accountLockOnFailedAttempts,
                    "TwoFA": vm.twoFA,
                    "CaptchEnable": vm.captchEnable,
                    "SSO": vm.sso
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
            console.log("vm.lengthRule", vm.lengthRule);

            if (!form.$valid) {
                if (!vm.name)  {
                    Notification.error({ message: 'Name is Required', positionY: 'bottom', positionX: 'right' });
                }
                if (vm.lengthRule < 8) {
                    Notification.error({ message: 'Length Rule is invalid', positionY: 'bottom', positionX: 'right' });
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
