(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .directive('uploadfile', function () {
        return {
            restrict: 'A',
            link: function (scope, element) {

                element.bind('click', function (e) {
                    console.log("uploadfile Triggered");
                    //angular.element(e.target).siblings('#fileInput').trigger('click');
                    angular.element('#fileInput').trigger('click');
                });
            }
        };
    });

})();