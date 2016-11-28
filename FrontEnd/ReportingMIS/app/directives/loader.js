(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .directive('loader', loader);

    loader.$inject = ['$rootScope'];

    function loader($rootScope) {
        return function ($scope, element, attrs) {
            $scope.$on("loader_show", function () {
                if (element.hasClass("hidden")) {
                    element.removeClass("hidden")
                }
            });
            return $scope.$on("loader_hide", function () {
                if (!element.hasClass("hidden")) {
                    element.addClass("hidden")
                }
            });
        }
    }

})();