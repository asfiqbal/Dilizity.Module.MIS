(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('layoutController', layoutController);

    layoutController.$inject = ['$scope', '$http', 'MenuService', 'FlashService'];
    function layoutController($scope, $http, MenuService, FlashService) {

        $scope.menuContainer = {
            left: false
        };

        //$scope.$on('ui.layout.loaded', function(){
        //    $timeout(function(){
        //        $scope.layout.one = true;
        //    });
        //})

        $scope.toggle = function(which) {
            console.log("$scope.layout", $scope.menuContainer);
            $scope.menuContainer[which] = !$scope.menuContainer[which];
        };

        (function initController() {

        })();

    }

})();
