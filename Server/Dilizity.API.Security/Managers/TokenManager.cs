using System;
using Dilizity.Core.DAL;
using Dilizity.Core.Util;
using Dilizity.API.Security.Models;
using System.Collections;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using System.IO;
using Dilizity.Business.Common;
using Dilizity.Business.Common.Services;
using ilizity.Business.Common.Model;
using Dilizity.Business.Common.Model;
using Newtonsoft.Json.Linq;
using System.Net.Http.Headers;

namespace Dilizity.API.Security.Managers
{

    public static class TokenManager
    {
        private static DateTime unixEpoch = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
        private const string GET_PERMISSION_DETAIL = "GetPermissionDetail";

        public static string Generate(BusService parameterBusService)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                string key = System.Configuration.ConfigurationManager.AppSettings["SecurityKey"];
                string iss = System.Configuration.ConfigurationManager.AppSettings["TokenIssuer"];
                string aud = System.Configuration.ConfigurationManager.AppSettings["Audience"];
                string expiration = System.Configuration.ConfigurationManager.AppSettings["Expiration"];
                int expInMinutes =  int.Parse(expiration.ToString());

                string loginId = (string)parameterBusService.Get(GlobalConstants.LOGIN_ID);

                var now = Math.Round((DateTime.UtcNow.AddMinutes(expInMinutes) - unixEpoch).TotalSeconds);

                var payload = new Dictionary<string, object>()
                {
                    { "SessionId", Guid.NewGuid() },
                    { "exp", now },
                    { "sub", loginId },
                    { "iss", iss  },
                    { "aud", aud  }
                };
                string encodedToken = JWT.JsonWebToken.Encode(payload, key, JWT.JwtHashAlgorithm.HS256);
                return encodedToken;
            }
        }

        public static bool Validate(BusService parameterBusService)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                bool outValue = false;

                try
                {
                    dynamic permissionObject = null;
                    using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                    {
                        string permissionId = (string)parameterBusService.Get(GlobalConstants.PERMISSION);

                        permissionObject = dataLayer.ExecuteAndGetSingleRowUsingKey(GET_PERMISSION_DETAIL, "PermissionId", permissionId);
                    }

                    if (permissionObject.DisableTokenValidation <= 0)
                    {
                        string token = ReadAuthorizationHeader(parameterBusService);
                        string key = System.Configuration.ConfigurationManager.AppSettings["SecurityKey"];
                        var payload = JWT.JsonWebToken.DecodeToObject(token, key) as IDictionary<string, object>;

                        var exp = payload["exp"].ToString();
                        CheckTokenExpiry(exp);
                        var issuer = payload["iss"].ToString();
                        CheckIssuer(issuer);
                    }
                    outValue = true;
                }
                catch (JWT.SignatureVerificationException ex)
                {
                    outValue = false;
                    Log.Error(typeof(TokenManager), ex.Message, ex);
                }

                return outValue;
            }
        }

        private static string ReadAuthorizationHeader(BusService parameterBusService)
        {
            HttpRequestHeaders headers = (HttpRequestHeaders)parameterBusService.Get(GlobalConstants.HTTP_HEADERS);

            IEnumerable<string> headerValues = headers.GetValues("Authorization");
            string token = headerValues.FirstOrDefault();
            Log.Error(typeof(TokenManager), "Token: " + token);

            string tokenScheme = System.Configuration.ConfigurationManager.AppSettings["TokenScheme"];

            token = token.Replace(tokenScheme + " ", string.Empty);
            return token;
        }


        private static void CheckTokenExpiry(string exp)
        {
            DateTime validTo = FromUnixTime(long.Parse(exp.ToString()));
            if (DateTime.Compare(validTo, DateTime.UtcNow) <= 0)
            {
                Log.Error(typeof(TokenManager), "Token Expired");
                throw new ApplicationBusinessException(GlobalErrorCodes.TokenExpired);
            }
        }

        private static void CheckIssuer(string issuer)
        {
            string iss = System.Configuration.ConfigurationManager.AppSettings["TokenIssuer"];

            if (!issuer.ToString().Equals(iss, StringComparison.Ordinal))
            {
                Log.Error(typeof(TokenManager), "Issuer not matched");
                throw new ApplicationBusinessException(GlobalErrorCodes.IssuerNotMatched);
            }
        }

        private static DateTime FromUnixTime(long unixTime)
        {
            return unixEpoch.AddSeconds(unixTime);
        }

        public static string GenerateCSRFToken(BusService parameterBusService)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                string token = Utility.Encrypt(Guid.NewGuid().ToString(), false);

                return token;
            }
        }



    }
}