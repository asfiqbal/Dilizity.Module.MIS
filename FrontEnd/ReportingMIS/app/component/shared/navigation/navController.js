(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('navController', navController);

    navController.$inject = ['$rootScope', '$scope', '$http', 'MenuService', 'Notification'];
    function navController($rootScope, $scope, $http, MenuService, Notification) {
        var vm = this;

        vm.loadMenu = loadMenu;
        vm.fullName = "";
        vm.picture = "";

        (function initController() {
        })();

        function loadMenu() {
            console.log("loadMenu Begin");

            MenuService.GetMenuData(vm.username,
                function (response) {
                    console.log("Success!");
                    var data = angular.fromJson(response.data);

                    if (data.ErrorCode == 0) {
                        console.log("data.Data.Menus", data.Data.Menus);
                        $scope.tree = data.Data.Menus;
                        vm.fullName = data.Data.Name;
                        vm.picture = data.Data.Picture;
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

            console.log("loadMenu End");
        };

        loadMenu();
    }

})();
