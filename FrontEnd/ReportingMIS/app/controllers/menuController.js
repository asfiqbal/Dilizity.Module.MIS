(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('menuController', menuController);

    menuController.$inject = ['$scope', '$http', 'MenuService', 'FlashService'];
    function menuController($scope, $http, MenuService, FlashService) {
        var vm = this;

        vm.loadMenu = loadMenu;

        (function initController() {
            // reset 
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
