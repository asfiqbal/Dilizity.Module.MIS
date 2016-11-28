using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Dilizity.Core.Util;
using Dilizity.Core.DAL;
using Dilizity.Business.Common.Services;

namespace Dilizity.Business.Common.Managers
{
    public class EmailBusinessManager : IAbstractBusiness
    {
        private const string GET_EMAIL_TEMPLATE = "GetEmailTemplate";
        private const string EMAIL_PERMISSION = ".Email";
        private const string GET_USER = "GetUser";

        public void Do(BusService parameterBusService)
        {
            try
            {
                using (FnTraceWrap tracer = new FnTraceWrap())
                {
                    using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.REPORT_SCHEMA))
                    {
                        string loginId = (string)parameterBusService.Get(GlobalConstants.LOGIN_ID);
                        if (parameterBusService.IsKeyPresent(GlobalConstants.PERMISSIONS))
                        {
                            List<string> permissions = (List<string>)parameterBusService.Get(GlobalConstants.PERMISSIONS);
                            string comaSeparatedPermission = Utility.AppendStringInStringList(permissions, EMAIL_PERMISSION);
                            dynamic secUser = dataLayer.ExecuteAndGetSingleRowUsingKey(GET_USER, "LoginId", loginId);

                            foreach (dynamic templateObject in dataLayer.ExecuteUsingKey(GET_EMAIL_TEMPLATE, "LoginId", loginId, "Permissions", comaSeparatedPermission))
                            {
                                string permissionName = templateObject.PermissionName;
                                string templateBody = templateObject.Template;
                                string subject = templateObject.Subject;
                                MessagingTemplateHelper mtHelper = new MessagingTemplateHelper();
                                templateBody = mtHelper.Resolve(templateBody, loginId);
                                EmailManager.Instance.Send(secUser.Email, subject, templateBody);
                                AuditHelper.Register(parameterBusService, loginId, permissionName, GlobalConstants.SUCCESS, templateBody);
                            }

                        }
                    }
                }
            }
            catch(Exception ex)
            {
                Log.Error(this.GetType(), ex.Message, ex);
            }
        }
    }
}
