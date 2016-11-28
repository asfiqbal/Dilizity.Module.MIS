//angular.module('ReportingMIS').
//  controller('userController', function ($scope, $http) {

//      $scope.gridOptions = {
//          enableGridMenu: true,
//          enableSelectAll: true,
//          exporterCsvFilename: 'myFile.csv',
//          exporterPdfDefaultStyle: { fontSize: 9 },
//          exporterPdfTableStyle: { margin: [30, 30, 30, 30] },
//          exporterPdfTableHeaderStyle: { fontSize: 10, bold: true, italics: true, color: 'red' },
//          exporterPdfHeader: { text: "My Header", style: 'headerStyle' },
//          exporterPdfFooter: function (currentPage, pageCount) {
//              return { text: currentPage.toString() + ' of ' + pageCount.toString(), style: 'footerStyle' };
//          },
//          exporterPdfCustomFormatter: function (docDefinition) {
//              docDefinition.styles.headerStyle = { fontSize: 22, bold: true };
//              docDefinition.styles.footerStyle = { fontSize: 10, bold: true };
//              return docDefinition;
//          },
//          exporterPdfOrientation: 'portrait',
//          exporterPdfPageSize: 'LETTER',
//          exporterPdfMaxGridWidth: 500,
//          exporterCsvLinkElement: angular.element(document.querySelectorAll(".custom-csv-link-location")),
//          onRegisterApi: function (gridApi) {
//              $scope.gridApi = gridApi;
//          }
//      };

//      reportSubmit

//      $http({
//          method: "GET",
//          url: 'http://localhost:54341/api/Security'
//      }).then(function mySucces(response) {
//          //$scope.UserList = response.data;
//          //alert(response.data[0].UserId);
//          $scope.gridOptions.data = response.data;
//          console.log(response.data[0].UserId);
//          //alert("response.data");
//          //alert(response.data[0].USER_ID);
//      }, function myError(response) {
//          //$scope.error = response.statusText;
//      });

//  });


(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('reportController', reportController);

    reportController.$inject = ['$scope', 'AuthenticationService', 'ReportService', 'FlashService'];
    function reportController($scope, AuthenticationService, ReportService, FlashService) {
        var vm = this;

        $scope.gridOptions = {
            enableGridMenu: true,
            enableSelectAll: true,
            data:[],
            exporterCsvFilename: 'myFile.csv',
            onRegisterApi: function (gridApi) {
                $scope.gridApi = gridApi;
            }
        };

        vm.reportSubmit = reportSubmit;

        (function initController() {
            // reset login status
            //AuthenticationService.ClearCredentials();
        })();

        function reportSubmit() {
            vm.dataLoading = true;
            alert("1");
            ReportService.ExecuteReport(function (response) {
                $scope.gridOptions.data = response.data;
                console.log(response.data[0].UserId);
            });
            vm.dataLoading = false;

        };
    }

})();
