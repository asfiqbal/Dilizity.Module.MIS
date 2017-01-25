(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .factory('HelperService', HelperService);

    HelperService.$inject = ['$rootScope'];
    function HelperService($rootScope) {
        var HelperService;
        return HelperService = {
            deepSearch: function deepSearch(theObject, key, value) {
                var result = null;
                if (theObject instanceof Array) {
                    for (var i = 0; i < theObject.length; i++) {
                        result = deepSearch(theObject[i], key, value);
                        if (result != null)
                            return result;
                    }
                }
                else {
                    for (var prop in theObject) {
                        //console.log(prop + ': ' + theObject[prop]);
                        if (theObject.hasOwnProperty(prop)) {
                            if (prop == key) {
                                if (theObject[prop] == value) {
                                    console.log('Object Found', value);
                                    return theObject;
                                }
                            }
                        }

                        if (theObject[prop] instanceof Object || theObject[prop] instanceof Array)
                            result = deepSearch(theObject[prop], key, value);
                        if (result != null)
                            return result;

                    }
                }
                return result;
            },
            IsNumber: function IsNumber(theObject) {
                return !(theObject === null || !angular.isDefined(theObject) || (angular.isNumber(theObject) && !isFinite(theObject)));
            },
            containsAny: function containsAny(str, substrings) {
                var outResult = false;
                for (var i = 0; i != substrings.length; i++) {
                    var substring = substrings[i];
                    if (str.indexOf(substring) != -1) {
                        outResult = true
                        break;
                    }
                }
                return outResult;
            }
        }
    };
})();