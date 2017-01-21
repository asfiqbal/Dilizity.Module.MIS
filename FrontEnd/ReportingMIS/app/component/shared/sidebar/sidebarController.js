(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('sidebarController', sidebarController);

    sidebarController.$inject = ['$rootScope', '$scope', '$http', 'SidebarService', 'Notification'];
    function sidebarController($rootScope, $scope, $http, SidebarService, Notification) {
        var vm = this;
        vm.menuClick = menuClick;
        vm.loadMenu = loadMenu;
        $scope.oneAtATime = true;

        (function initController() {
            $scope.oneAtATime = true;
            loadMenu();
        })();

        function menuClick($event) {
            console.log("menuClick Begin");
            //console.log("$event.currentTarget", $($event.currentTarget).parent());

            var $SIDEBAR_MENU = $('#sidebar-menu')
            var $li = $($event.currentTarget).parent();
            //console.log("$event", $($event.target).parent().parent());
            var liElement = $($event.currentTarget).parent();
            //console.log("liElement", liElement);

            //console.log("liElement.hasClass('active')", liElement.hasClass('active'));
            //console.log("$SIDEBAR_MENU", $SIDEBAR_MENU);

            if (liElement.hasClass('active')) {
                liElement.removeClass('active active-sm');
                $('ul:first', $li).slideUp(function () {
                });
            } else {
                if (!$li.parent().is('.child_menu')) {
                    //console.log(".child_menu", 1);
                    $SIDEBAR_MENU.find('li').removeClass('active active-sm');
                    $SIDEBAR_MENU.find('li ul').slideUp();
                }

                liElement.addClass('active');
                liElement.slideDown();

                $('ul:first', $li).slideDown(function () {
                });
            }
            //vm.dataLoading = true;
            console.log("menuClick End");
        };


        function loadMenu() {
            console.log("loadMenu Begin");
            //vm.dataLoading = true;
            //$scope.groups = [
            //    {
            //        title: 'Administration',
            //        styleClass: 'fa fa-edit',
            //        content: [
            //            {   
            //                menuTitle:'User',
            //                actionURL: "index.user"
            //            },
            //            {
            //                menuTitle: 'Role',
            //                actionURL: "index.Role"
            //            },
            //            {
            //                menuTitle: 'Maker List',
            //                actionURL: "index.Maker"
            //            },
            //            {
            //                menuTitle: 'Checker List',
            //                actionURL: "index.Checker"
            //            }
            //            ]
            //    },
            //    {
            //        title: 'Report',
            //        styleClass: 'fa fa-desktop',
            //        content: [
            //            {
            //                menuTitle: 'Connection Management',
            //                actionURL: "index.Connection"
            //            },
            //            {
            //                menuTitle: 'Report',
            //                actionURL: "index.Report"
            //            }]
            //    }
            //];
            var tmpUserName = $rootScope.globals.currentUser.username;

            SidebarService.GetMenuData(tmpUserName, function (response) {
                $scope.groups = angular.fromJson(response.data);
                console.log("GetMenuData Called");
                console.log($scope.groups);
            }, function (response) {
                Notification.error({ message: "Side Bar Menu Failed", positionY: 'bottom', positionX: 'right' });
            });
            console.log("loadMenu End");
        };

    }

})();
