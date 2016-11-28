(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .factory('ReportService', ReportService);

    ReportService.$inject = ['$http', '$cookieStore', '$rootScope', '$timeout', 'UserService'];
    function ReportService($http, $cookieStore, $rootScope, $timeout, UserService) {
        var service = {};

        service.ExecuteReport = ExecuteReport;

        return service;

        function ExecuteReport(callback) {

            /* Dummy authentication for testing, uses $timeout to simulate api call
             ----------------------------------------------*/
            //$timeout(function () {
            //    var response;
            //    var user = UserService.GetByUsername(username);
            //    if (user !== null && user.password === password) {
            //        response = { success: true };
            //    } else {
            //        response = { success: false, message: 'Username or password is incorrect' };
            //    }
            //    callback(response);
            //}, 1000);

            /* Use this for real execution
             ----------------------------------------------*/
            $http({
                method: "GET",
                url: 'http://localhost:54341/api/Security/GetAll'
            }).then(function mySucces(response) {
                alert(response.data[0].UserId);
                callback(response);
            }, function myError(response) {
                alert(response);
                //$scope.error = response.statusText;
            });

        }
         
    }

})();