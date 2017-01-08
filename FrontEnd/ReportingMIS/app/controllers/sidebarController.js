(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .controller('sidebarController', sidebarController);

    sidebarController.$inject = ['$scope', '$http', 'MenuService', 'FlashService'];
    function sidebarController($scope, $http, MenuService, FlashService) {
        var vm = this;
        vm.menuClick = menuClick;
        vm.loadMenu = loadMenu;
        $scope.oneAtATime = true;

        (function initController() {
            $scope.oneAtATime = true;
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
            $scope.groups = [
                {
                    title: 'Administration',
                    styleClass: 'fa fa-edit',
                    content: [
                        {   
                            menuTitle:'User',
                            actionURL: "index.user"
                        },
                        {
                            menuTitle: 'Role',
                            actionURL: "index.Role"
                        }]
                },
                {
                    title: 'Report',
                    styleClass: 'fa fa-desktop',
                    content: [
                        {
                            menuTitle: 'Connection Management',
                            actionURL: "index.Connection"
                        },
                        {
                            menuTitle: 'Report',
                            actionURL: "index.Report"
                        }]
                }
            ];
            console.log("loadMenu End");
        };

        loadMenu();
    }

})();
