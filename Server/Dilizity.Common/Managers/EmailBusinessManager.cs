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
    public class EmailBusinessManager : IAbstractBusiness
    {
        private const string GET_TEMPLATE = "GetTemplate";
        private const string EMAIL_PERMISSION = ".Email";
        private const string GET_USER = "GetUser";
        private const string INSERT_NOTIFICATION = "InsertNotification";
        private const string SMTP_SERVER_FROM_ADDRESS = "SMTP_SERVER_FROM_ADDRESS";
        private const int EMAIL_TEMPLATE_TYPE = 1;

        public void Do(BusService parameterBusService)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                Operation childOperation = null;
                try
                {

                    childOperation = new Operation(parameterBusService);
                    childOperation.PermissionClass = typeof(EmailBusinessManager).ToString();
                    childOperation.saveToDB();

                    Operation op = (Operation)parameterBusService.Get(GlobalConstants.OPERATION_ID);

                    string permissionName = (string)parameterBusService.Get(GlobalConstants.PERMISSION);
                    string emailPermissionName = permissionName + EMAIL_PERMISSION;
                    string loginId = (string)parameterBusService.Get(GlobalConstants.LOGIN_ID);
                    string fromEmailAddress = SystemConfigurationManager.Instance.Get(SMTP_SERVER_FROM_ADDRESS);
                    using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.REPORT_SCHEMA, false, true))
                    {
                        dynamic secUser = dataLayer.ExecuteAndGetSingleRowUsingKey(GET_USER, "LoginId", loginId);

                        foreach (dynamic templateObject in dataLayer.ExecuteUsingKey(GET_TEMPLATE, "LoginId", loginId, "PermissionName", emailPermissionName, "TemplateType", EMAIL_TEMPLATE_TYPE))
                        {
                            string templateBody = templateObject.Template;
                            string subject = templateObject.Subject;
                            MessagingTemplateHelper mtHelper = new MessagingTemplateHelper();
                            templateBody = mtHelper.Resolve(templateBody, op.OperationId.ToString());
                            string encryptBody = Utility.Encrypt(templateBody, true);
                            dataLayer.DelayExecuteNonQueryUsingKey(INSERT_NOTIFICATION, "OperationId", op.OperationId, "NotificationType", "Email", "From", fromEmailAddress, "To", secUser.Email, "CC", "", "Subject", subject, "Body", encryptBody, "Status", "Pending", "CreatedBy", loginId);
                            //EmailManager.Instance.Send(secUser.Email, subject, templateBody);
                        }
                        dataLayer.DelayExecuteBulk();
                    }
                    childOperation.Status = GlobalConstants.SUCCESS;
                    childOperation.saveToDB();
                }
                catch (Exception ex)
                {
                    Log.Error(this.GetType(), ex.Message, ex);
                    childOperation.Status = GlobalConstants.FAILURE;
                    childOperation.saveToDB();
                    throw;
                }
            }
        }
    }
}
