(function () {
    'use strict';

    angular
       .module('ReportingMIS')
       .constant('AppSettings', {
           ver: '1.0.0.0', language: 'en',
           production: false,
           tokenScheme: 'Dilizity',
           baseUrl: 'http://localhost:54341/api/'
       })
       .config(function (NotificationProvider, $httpProvider) {

           $httpProvider.defaults.withCredentials = true;

           NotificationProvider.setOptions({
               delay: 10000,
               startTop: 20,
               startRight: 10,
               verticalSpacing: 20,
               horizontalSpacing: 20,
               positionX: 'left',
               positionY: 'bottom'
           });

       });

})();
