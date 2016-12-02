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

        function GetMenuData(username, callback) {

            /* Dummy authentication for testing, uses $timeout to simulate api call
             ----------------------------------------------*/
            //$timeout(function () {
            //    var response = [{
            //        name: "Report",
            //        link: "#",
            //        subtree: [{
            //            name: "MIS Report",
            //            link: "#",
            //            subtree: [{
            //                name: "Report1",
            //                link: "index.Report1"
            //            }, {
            //                name: "Metal Gear 2: Solid Snake",
            //                link: "metal-gear2"
            //            }, {
            //                name: "Metal Gear Solid: The Twin Snakes",
            //                link: "metal-gear-solid"
            //            }]
            //        }, {
            //            name: "divider",
            //            link: "#"
            //        }, {
            //            name: "Castlevania",
            //            link: "#",
            //            subtree: [{
            //                name: "Castlevania",
            //                link: "#"
            //            }, {
            //                name: "Castlevania II: Simon's Quest",
            //                link: "#"
            //            }, {
            //                name: "Castlevania III: Dracula's Curse",
            //                link: "#"
            //            }]
            //        }]
            //    }, {
            //        name: "SNK",
            //        link: "#",
            //        subtree: [{
            //            name: "Fatal Fury",
            //            link: "#",
            //            subtree: [{
            //                name: "Fatal Fury",
            //                link: "#"
            //            }, {
            //                name: "Fatal Fury 2",
            //                link: "#"
            //            }, {
            //                name: "Fatal Fury: King of Fighters",
            //                link: "#"
            //            }, {
            //                name: "Fatal Fury Special",
            //                link: "#"
            //            }]
            //        }, {
            //            name: "divider",
            //            link: "#"
            //        }, {
            //            name: "Metal Slug",
            //            link: "#",
            //            subtree: [{
            //                name: "Metal Slug",
            //                link: "#"
            //            }, {
            //                name: "Metal Slug 2",
            //                link: "#"
            //            }, {
            //                name: "Metal Slug 3",
            //                link: "#"
            //            }, {
            //                name: "Metal Slug 4",
            //                link: "#"
            //            }, {
            //                name: "Metal Slug 5",
            //                link: "#"
            //            }, {
            //                name: "Metal Slug 6",
            //                link: "#"
            //            }, {
            //                name: "Metal Slug 7",
            //                link: "#"
            //            }, {
            //                name: "Metal Slug X",
            //                link: "#"
            //            }]
            //        }]
            //    }, {
            //        name: "Sega",
            //        link: "#",
            //        subtree: [{
            //            name: "After Burner",
            //            link: "#"
            //        }, {
            //            name: "R-Type",
            //            link: "#"
            //        }]
            //    }, {
            //        name: "Nintendo",
            //        link: "#",
            //        subtree: [{
            //            name: "Double Dragon",
            //            link: "#"
            //        }, {
            //            name: "Super Mario Bros.",
            //            link: "#"
            //        }]
            //    }]
       
            //    callback(response);
            //}, 1000);

            /* Use this for real authentication
             ----------------------------------------------*/
            var tmpUserName = $rootScope.globals.currentUser.username;
            $http.get(AppSettings.baseUrl + '/Security/GetMenus/' + tmpUserName)
                .then(function (response) {
                    callback(response);
                }, function (response) {
                    callback(response);
                }
            );

        }



    }


})();