(function () {
    'use strict';

    angular
       .module('ReportingMIS')
       .constant('AppSettings', { ver: '1.0.0.0', language: 'en', production: false, baseUrl: 'http://asifiqbal/ReportingAPI/api/' })
       .config(function (NotificationProvider) {
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
