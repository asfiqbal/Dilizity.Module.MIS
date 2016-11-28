(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .factory('UserService', UserService);

    UserService.$inject = ['$timeout'];
    function UserService($timeout) {

        var service = {};

        service.GetByUsername = GetByUsername;
        return service;

        function GetByUsername(username) {
            var user = { loginId: 'admin', password: 'admin' };
            return user;
        }


    }
})();