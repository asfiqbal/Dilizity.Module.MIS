(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .factory('CommunicationService', CommunicationService);

    CommunicationService.$inject = ['$http', '$cookieStore', '$rootScope', '$timeout', 'AppSettings'];
    function CommunicationService($http, $cookieStore, $rootScope, $timeout, AppSettings) {
        var objects = {};

        var Set = function (key, newObj) {
            objects[key] = newObj;
        }

        var Get = function (key) {
            var outObject;

            if (key in objects)
            {
                outObject = objects[key];
                delete objects[key];
            }

            return outObject;
        }

        return {
            Set: Set,
            Get: Get
        };

    };

})();