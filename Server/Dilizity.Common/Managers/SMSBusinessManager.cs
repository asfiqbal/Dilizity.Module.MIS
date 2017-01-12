using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Dilizity.Core.Util;
using Dilizity.Core.DAL;
using Dilizity.Business.Common.Services;
using ilizity.Business.Common.Model;

namespace Dilizity.Business.Common.Managers
{
    public class SMSBusinessManager : IAbstractBusiness
    {
        private const string GET_TEMPLATE = "GetTemplate";
        private const string SMS_PERMISSION = ".SMS";
        private const string GET_USER = "GetUser";

        public void Do(BusService parameterBusService)
        {
            try
            {
                using (FnTraceWrap tracer = new FnTraceWrap())
                {
                    Operation childOperation = new Operation(parameterBusService);
                    childOperation.PermissionClass = typeof(EmailBusinessManager).ToString();
                    childOperation.saveToDB();

                    string loginId = (string)parameterBusService.Get(GlobalConstants.LOGIN_ID);

                    using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.REPORT_SCHEMA))
                    {
                        if (parameterBusService.IsKeyPresent(GlobalConstants.PERMISSION))
                        {
                            string permission = (string)parameterBusService.Get(GlobalConstants.PERMISSION);
                            dynamic secUser = dataLayer.ExecuteAndGetSingleRowUsingKey(GET_USER, "LoginId", loginId);

                            foreach (dynamic templateObject in dataLayer.ExecuteUsingKey(GET_TEMPLATE, "LoginId", loginId, "Permission", permission))
                            {
                                string permissionName = templateObject.PermissionName;
                                string templateBody = templateObject.Template;
                                string subject = templateObject.Subject;
                                MessagingTemplateHelper mtHelper = new MessagingTemplateHelper();
                                templateBody = mtHelper.Resolve(templateBody, childOperation.ParentOperationId.ToString());
                                //EmailManager.Instance.Send(secUser.Email, subject, templateBody);
                                //AuditHelper.Register(parameterBusService, loginId, permissionName, GlobalConstants.SUCCESS, templateBody);
                            }

                        }
                        childOperation.Status = GlobalConstants.SUCCESS;
                        childOperation.saveToDB();
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
