(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('layoutController', layoutController);

    layoutController.$inject = ['$scope', '$http', 'MenuService', 'FlashService'];
    function layoutController($scope, $http, MenuService, FlashService) {

        $scope.menuContainer = {
            left: true
        };

        $scope.toggle = function(which) {
            //console.log("$scope.layout", $scope.menuContainer);
            if (angular.element(document.body).hasClass('nav-sm')) {
                angular.element('#sidebar-menu').find('li.active-sm ul').show();
                angular.element('#sidebar-menu').find('li.active-sm').addClass('active').removeClass('active-sm');
            } else {
                angular.element('#sidebar-menu').find('li.active ul').hide();
                console.log("#sidebar-menu", angular.element('#sidebar-menu').find('li.active'));
                angular.element('#sidebar-menu').find('li.active').addClass('active-sm').removeClass('active');
            }

            angular.element(document.body).toggleClass('nav-md nav-sm');
        };

        (function initController() {

        })();

    }

})();
