using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Dilizity.Core.Util;
using Dilizity.Core.DAL;
using Dilizity.Business.Common.Services;
using ilizity.Business.Common.Model;
using Newtonsoft.Json.Linq;
using Dilizity.Business.Common;

namespace Dilizity.API.Security.Managers
{
    public class BulkResetEmailBusinessManager : IAbstractBusiness
    {
        private const string GET_TEMPLATE = "GetTemplate";
        private const string GET_USERS_EMAIL = "GetUsersEmail";
        private const string INSERT_NOTIFICATION = "InsertNotification";
        private const string SMTP_SERVER_FROM_ADDRESS = "SMTP_SERVER_FROM_ADDRESS";
        private const string ENCRYPT_MSG_BODY = "ENCRYPT_MSG_BODY";
        
        private const int EMAIL_TEMPLATE_TYPE = 1;

        public void Do(BusService parameterBusService)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                Operation childOperation = null;
                try
                {

                    childOperation = new Operation(parameterBusService);
                    childOperation.PermissionClass = typeof(BulkResetEmailBusinessManager).ToString();
                    childOperation.saveToDB();

                    Operation op = (Operation)parameterBusService.Get(GlobalConstants.OPERATION_ID);

                    string permissionName = (string)parameterBusService.Get(GlobalConstants.PERMISSION);
                    JObject model = (JObject)parameterBusService.Get("Model");
                    JArray tmpList = (JArray)model["Users"];
                    string loginId = (string)parameterBusService.Get(GlobalConstants.LOGIN_ID);
                    string[] UserIds = tmpList.ToObject<string[]>();
                    string csUserIds = string.Join(",", UserIds);

                    string fromEmailAddress = SystemConfigurationManager.Instance.Get(SMTP_SERVER_FROM_ADDRESS);
                    using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.REPORT_SCHEMA, false, true))
                    {
                        IEnumerable<dynamic> tempList = dataLayer.ExecuteUsingKey(GET_USERS_EMAIL, "UserIds", csUserIds);
                        List < dynamic > userList = tempList.ToList<dynamic>();

                        foreach (dynamic User in userList)
                        {
                            foreach (dynamic templateObject in dataLayer.ExecuteUsingKey(GET_TEMPLATE, "LoginId", loginId, "PermissionName", permissionName, "TemplateType", EMAIL_TEMPLATE_TYPE))
                            {
                                string templateBody = templateObject.Template;
                                string subject = templateObject.Subject;
                                MessagingTemplateHelper mtHelper = new MessagingTemplateHelper();
                                templateBody = mtHelper.Resolve(templateBody, User.UserId.ToString());
                                string needToEncryptMessage = SystemConfigurationManager.Instance.Get(ENCRYPT_MSG_BODY);
                                if (needToEncryptMessage.ToUpper() == "TRUE")
                                { 
                                    templateBody = Utility.Encrypt(templateBody, false);
                                }
                                dataLayer.DelayExecuteNonQueryUsingKey(INSERT_NOTIFICATION, "OperationId", op.OperationId, "NotificationType", "Email", "From", fromEmailAddress, "To", User.Email, "CC", "", "Subject", subject, "Body", templateBody, "Status", "Pending", "CreatedBy", loginId);
                            }
                            dataLayer.DelayExecuteBulk();
                        }
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
