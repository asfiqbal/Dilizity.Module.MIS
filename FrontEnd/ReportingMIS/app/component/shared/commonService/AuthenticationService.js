(function () {
    'use strict';

    angular
        .module('ReportingMIS')
        .factory('AuthenticationService', AuthenticationService);

    AuthenticationService.$inject = ['$http', '$cookieStore', '$rootScope', '$timeout', 'AppSettings', 'UniversalService', '$cookies'];
    function AuthenticationService($http, $cookieStore, $rootScope, $timeout, AppSettings, UniversalService, $cookies) {
        var service = {};

        service.Login = Login;
        service.TwoFAValidate = TwoFAValidate;
        service.ChangePassword = ChangePassword;

        service.SetCredentials = SetCredentials;
        service.ClearCredentials = ClearCredentials;
        service.GetSecurityToken = GetSecurityToken;

        return service;

        function Login(permission, username, password, successCallBack, errorCallBack) {
            console.log("Login Begin");

            var encPassword = Base64.encode(password);

            var model = {
                Password: encPassword
            }

            UniversalService.Do(permission, username, model, successCallBack, errorCallBack);

            console.log("Login End");
        }

        function TwoFAValidate(permission, username, twoFACode, successCallBack, errorCallBack) {
            console.log("TwoFAValidate Begin");

            var encCode = Base64.encode(twoFACode);

            var model = {
                Code: encCode
            }

            UniversalService.Do(permission, username, model, successCallBack, errorCallBack);

            console.log("TwoFAValidate End");
        }


        function ChangePassword(permission, loginId, oldPassword, newPassword, successCallBack, errorCallBack) {
            console.log("ChangePassword Begin");

            var encOldPassword = Base64.encode(oldPassword);
            var encNewPassword = Base64.encode(newPassword);


            var model = {
                OldPassword: encOldPassword,
                NewPassword: encNewPassword
            }

            UniversalService.Do(permission, loginId, model, successCallBack, errorCallBack);

            console.log("ChangePassword Begin");
        }

        function SetCredentials(username, authdata) {
            //var authdata = Base64.encode(username + ':' + password);

            $rootScope.globals = {
                currentUser: {
                    username: username,
                    authdata: authdata
                }
            };

            console.log("authdata", authdata);

            
            $http.defaults.headers.common['Authorization'] = AppSettings.tokenScheme + ' ' + authdata; // jshint ignore:line
            //$cookieStore.put('globals', $rootScope.globals);
            sessionStorage.globals = $rootScope.globals;
        }

        function ClearCredentials() {
            $rootScope.globals = {};
            $cookieStore.remove('globals');
            $cookies.remove("XSRF-TOKEN");
            delete sessionStorage.globals;
            $http.defaults.headers.common.Authorization = AppSettings.tokenScheme;
        }

        function GetSecurityToken(successCallBack, errorCallBack) {
            console.log("GetSecurityToken Begin");

            $http.get(AppSettings.baseUrl + 'Security/GetSecurityToken')
                .then(function (response) {
                    var xsrfCookie = $cookies.get('XSRF-TOKEN');
                    console.log("Security Cookie", xsrfCookie);

                    $http.defaults.headers.common['X-XSRF-Token'] = '12345678';
                    successCallBack(response);
                }, function (response) {
                    errorCallBack(response);
                }
            );

            console.log("GetSecurityToken End");
        }

    }

    // Base64 encoding service used by AuthenticationService
    var Base64 = {

        keyStr: 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=',

        encode: function (input) {
            var output = "";
            var chr1, chr2, chr3 = "";
            var enc1, enc2, enc3, enc4 = "";
            var i = 0;

            do {
                chr1 = input.charCodeAt(i++);
                chr2 = input.charCodeAt(i++);
                chr3 = input.charCodeAt(i++);

                enc1 = chr1 >> 2;
                enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
                enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
                enc4 = chr3 & 63;

                if (isNaN(chr2)) {
                    enc3 = enc4 = 64;
                } else if (isNaN(chr3)) {
                    enc4 = 64;
                }

                output = output +
                    this.keyStr.charAt(enc1) +
                    this.keyStr.charAt(enc2) +
                    this.keyStr.charAt(enc3) +
                    this.keyStr.charAt(enc4);
                chr1 = chr2 = chr3 = "";
                enc1 = enc2 = enc3 = enc4 = "";
            } while (i < input.length);

            return output;
        },

        decode: function (input) {
            var output = "";
            var chr1, chr2, chr3 = "";
            var enc1, enc2, enc3, enc4 = "";
            var i = 0;

            // remove all characters that are not A-Z, a-z, 0-9, +, /, or =
            var base64test = /[^A-Za-z0-9\+\/\=]/g;
            if (base64test.exec(input)) {
                window.alert("There were invalid base64 characters in the input text.\n" +
                    "Valid base64 characters are A-Z, a-z, 0-9, '+', '/',and '='\n" +
                    "Expect errors in decoding.");
            }
            input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");

            do {
                enc1 = this.keyStr.indexOf(input.charAt(i++));
                enc2 = this.keyStr.indexOf(input.charAt(i++));
                enc3 = this.keyStr.indexOf(input.charAt(i++));
                enc4 = this.keyStr.indexOf(input.charAt(i++));

                chr1 = (enc1 << 2) | (enc2 >> 4);
                chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
                chr3 = ((enc3 & 3) << 6) | enc4;

                output = output + String.fromCharCode(chr1);

                if (enc3 != 64) {
                    output = output + String.fromCharCode(chr2);
                }
                if (enc4 != 64) {
                    output = output + String.fromCharCode(chr3);
                }

                chr1 = chr2 = chr3 = "";
                enc1 = enc2 = enc3 = enc4 = "";

            } while (i < input.length);

            return output;
        }
    };

})();