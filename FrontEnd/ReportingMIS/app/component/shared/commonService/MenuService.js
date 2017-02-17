(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .factory('MenuService', MenuService);

    MenuService.$inject = ['$http', '$cookieStore', '$rootScope', '$timeout', 'AppSettings'];
    function MenuService($http, $cookieStore, $rootScope, $timeout, AppSettings) {
        var service = {};

        service.GetMenuData = GetMenuData;

        return service;

        function GetMenuData(username, successCallBack, errorCallBack) {

            var tmpUserName = $rootScope.globals.currentUser.username;
            $http.get(AppSettings.baseUrl + 'Security/GetMenus/' + tmpUserName)
                .then(function (response) {
                    successCallBack(response);
                }, function (response) {
                    errorCallBack(response);
                }
            );

        }



    }


})();