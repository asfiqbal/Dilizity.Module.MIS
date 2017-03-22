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
        private const string INSERT_NOTIFICATION = "InsertNotification";
        private const string MOBILE_FROM_NUMBER = "MOBILE_FROM_NUMBER";
        private const int SMS_TEMPLATE_TYPE = 2;
        private const string ENCRYPT_MSG_BODY = "ENCRYPT_MSG_BODY";


        public void Do(BusService parameterBusService)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                Operation childOperation = null;
                try
                {
                    childOperation = new Operation(parameterBusService);
                    childOperation.PermissionClass = typeof(SMSBusinessManager).ToString();
                    childOperation.saveToDB();

                    Operation op = (Operation)parameterBusService.Get(GlobalConstants.OPERATION_ID);

                    string permissionName = (string)parameterBusService.Get(GlobalConstants.PERMISSION);
                    string SMSPermissionName = permissionName + SMS_PERMISSION;
                    string loginId = (string)parameterBusService.Get(GlobalConstants.LOGIN_ID);
                    string fromMobileNo = SystemConfigurationManager.Instance.Get(MOBILE_FROM_NUMBER);

                    using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.REPORT_SCHEMA, false, true))
                    {
                        dynamic secUser = dataLayer.ExecuteAndGetSingleRowUsingKey(GET_USER, "LoginId", loginId);

                        foreach (dynamic templateObject in dataLayer.ExecuteUsingKey(GET_TEMPLATE, "LoginId", loginId, "PermissionName", SMSPermissionName, "TemplateType", SMS_TEMPLATE_TYPE))
                        {
                            string templateBody = templateObject.Template;
                            string subject = templateObject.Subject;
                            MessagingTemplateHelper mtHelper = new MessagingTemplateHelper();
                            templateBody = mtHelper.Resolve(templateBody, childOperation.ParentOperationId.ToString());
                            string needToEncryptMessage = SystemConfigurationManager.Instance.Get(ENCRYPT_MSG_BODY);
                            if (needToEncryptMessage.ToUpper() == "TRUE")
                            {
                                templateBody = Utility.Encrypt(templateBody, false);
                            }
                            dataLayer.DelayExecuteNonQueryUsingKey(INSERT_NOTIFICATION, "OperationId", op.OperationId, "NotificationType", "SMS", "From", fromMobileNo, "To", secUser.MobileNumber, "CC", "", "Subject", subject, "Body", templateBody, "Status", "Pending", "CreatedBy", loginId);
                        }
                        dataLayer.DelayExecuteBulk();
                    }
                    childOperation.ErrorCode = GlobalErrorCodes.Success;
                    childOperation.Status = GlobalConstants.SUCCESS;
                    childOperation.saveToDB();
                }
                catch (Exception ex)
                {
                    Log.Error(this.GetType(), ex.Message, ex);
                    childOperation.ErrorCode = GlobalErrorCodes.SystemError;
                    childOperation.Status = GlobalConstants.FAILURE;
                    childOperation.saveToDB();
                    throw;
                }
            }

        }
    }
}
