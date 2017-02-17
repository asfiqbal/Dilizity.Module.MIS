(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .factory('httpInterceptor', function ($q, $rootScope, $log, $injector) {

            var numLoadings = 0;

            return {
                request: function (config) {

                    numLoadings++;

                    // Show loader
                    $rootScope.$broadcast("loader_show");
                    return config || $q.when(config)

                },
                response: function (response) {

                    if ((--numLoadings) === 0) {
                        // Hide loader
                        $rootScope.$broadcast("loader_hide");
                    }

                    //Session validation
                    if (response.data.ErrorCode == 4) {
                        $injector.get('$state').go('login');
                        console.log("Session invalidated", loggedIn);
                    }

                    return response || $q.when(response);

                },
                responseError: function (response) {

                    if (!(--numLoadings)) {
                        // Hide loader
                        $rootScope.$broadcast("loader_hide");
                    }

                    return $q.reject(response);
                }
            };
        })
        .config(function ($httpProvider) {
            $httpProvider.interceptors.push('httpInterceptor');
        });
  
})();


