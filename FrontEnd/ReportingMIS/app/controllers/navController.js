(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('navController', navController);

    navController.$inject = ['$rootScope', '$scope', '$http', 'MenuService', 'FlashService'];
    function navController($rootScope, $scope, $http, MenuService, FlashService) {
        var vm = this;

        vm.loadMenu = loadMenu;
        vm.fullName = "";

        (function initController() {
            vm.fullName = "Asif Iqbal";
        })();

        function loadMenu() {
            console.log("loadMenu Begin");
            //vm.dataLoading = true;
            MenuService.GetMenuData(vm.username, function (response) {
                $scope.tree = angular.fromJson(response.data);
                console.log("GetMenuData Called");
                console.log($scope.tree);
            });
            console.log("loadMenu End");
        };

        loadMenu();
    }

})();
