using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Dilizity.Core.DAL;
using System.Dynamic;
using Dilizity.Messaging;
using Dilizity.Business.Common;

namespace DALTest
{
    class Program
    {   
        static void Main(string[] args)
        {
            //TestInsertSpecificReport();
            //TestGetSpecificReport();
            //TestTransactionCommit();
            //TestExecuteScalar();
            //TestGetAllUsers();
            //TestEncrypt();
            //TestExecuteBulkNonQueryUsingKey();
            //StringMessagingAgentTest();
            //TestEmail();
            TestSMS();
        }

        //static void Test1()
        //{
        //    string Provider = @"System.Data.SqlClient";
        //    string ConnectionString = "Server=172.16.0.250;Database=Admin;User Id=sa;Password=Avanza123;";
        //    string CommandText = string.Empty;
            
        //    using (var dataLayer = new DynamicDataLayer(Provider, ConnectionString))
        //    {
        //        foreach (dynamic record in dataLayer.ExecuteText(CommandText))
        //        {
        //            int USER_ID = record.USER_ID;
        //            string LOGID_ID = record.LOGIN_ID;

        //        }
        //    }
        //}

        static void TestGetSpecificReport()
        {
            string Provider = @"System.Data.SqlClient";
            string CommandKey = "GetSpecificReport";
            string CommandText = string.Empty;


            using (var dataLayer = new DynamicDataLayer(Provider))
            {
                foreach (dynamic record in dataLayer.ExecuteUsingKey(CommandKey, "ReportId", 1))
                {
                    int REPORT_ID = record.ReportId;
                    string REPORT_NAME = record.REPORT_NAME;

                }
            }
        }

        static void TestGetAllUsers()
        {
            string CommandText = string.Empty;

            using (var dataLayer = new DynamicDataLayer("Security"))
            {
                foreach (dynamic record in dataLayer.ExecuteUsingKey("GetAllUsers"))
                {
                    int REPORT_ID = record.LoginId;

                }
            }
        }

        static void TestExecuteBulkNonQueryUsingKey()
        {
            string CommandText = string.Empty;
            List<dynamic> dynamicObject = new List<dynamic>();
            for (int i=0; i < 5; i++)
            {
                dynamic tmpObject = new ExpandoObject();
                tmpObject.LoginId = "Admin";
                tmpObject.PermissionName = "Dilizity.Login";
                tmpObject.IsSuccess = 1;
                tmpObject.Data = i.ToString();
                tmpObject.CreatedBy = "Admin";
                dynamicObject.Add(tmpObject);
            }

            using (var dataLayer = new DynamicDataLayer("Security"))
            {
                int Success = dataLayer.ExecuteBulkNonQueryUsingKey("InsertAudit", dynamicObject);
            }
        }

        static void TestGetUserCredentials()
        {
            string CommandText = string.Empty;

            using (var dataLayer = new DynamicDataLayer("Security"))
            {
                foreach (dynamic record in dataLayer.ExecuteUsingKey("GetUserCredentials","LoginId","Admin"))
                {
                    int REPORT_ID = record.USER_ID;
                    string REPORT_NAME = record.LOGIN_ID;

                }
            }
        }


        static void TestInsertSpecificReport()
        {
            string Provider = @"System.Data.SqlClient";
            string CommandKey = "InsertReport";
            string CommandText = string.Empty;

            using (var dataLayer = new DynamicDataLayer(Provider))
            {
                int result = dataLayer.ExecuteNonQueryUsingKey(CommandKey, "ReportName", "GeneralReport", "ReportDisplayName", "GeneralReport", "ReportSQL", "SELECT * FROM REPORT");
            }
        }

        static void TestTransactionRollback()
        {
            string Provider = @"System.Data.SqlClient";
            string CommandKey1 = "InsertReport";
            string CommandKey2 = "UpdateReport";

            string CommandText = string.Empty;

            using (var dataLayer = new DynamicDataLayer(Provider))
            {
                dataLayer.BeginTransaction();
                int result = dataLayer.ExecuteNonQueryUsingKey(CommandKey1, "ReportName", "General Report 1", "ReportDisplayName", "GeneralReport 2", "ReportSQL", "SELECT * FROM REPORT1");
                result = dataLayer.ExecuteNonQueryUsingKey(CommandKey2);
                dataLayer.RollbackTransaction();
            }
        }

        static void TestTransactionCommit()
        {
            string Provider = @"System.Data.SqlClient";
            string CommandKey1 = "InsertReport";
            string CommandKey2 = "UpdateReport";

            string CommandText = string.Empty;

            using (var dataLayer = new DynamicDataLayer(Provider))
            {
                dataLayer.BeginTransaction();
                int result = dataLayer.ExecuteNonQueryUsingKey(CommandKey1, "ReportName", "General Report 1", "ReportDisplayName", "GeneralReport 2", "ReportSQL", "SELECT * FROM REPORT1");
                result = dataLayer.ExecuteNonQueryUsingKey(CommandKey2);
                dataLayer.CommitTransaction();
            }
        }

        //static void TestExecuteScalar()
        //{
        //    using (var dataLayer = new DynamicDataLayer())
        //    {
        //        int result = (int)dataLayer.ExecuteScalarUsingKey("CountReport");
        //    }
        //}

        static void TestEncrypt()
        {
            string outString = Dilizity.Core.Util.Utility.Encrypt("ujala34961897", false);
            //string inString = Dilizity.Core.Util.Utility("ujala34961897", false);
        }

        static void StringMessagingAgentTest()
        {
            string message = @"Dear <USER_NAME/> " +
                            "Your report has been generated at <USER_EMAIL_ADDRESS/>." + Environment.NewLine +
                             "Thanks for doing business with us. " + Environment.NewLine +
                             "Best Regards," + Environment.NewLine +
                             "Team";
            IMessagingDataAgent dataAgent = new DBDataAgent();
            IMetaDataReader reader = MetaDataAgent.Instance;
            if (dataAgent.Load("Report"))
            {
                IMessagingAgent stringAgent = new TextMessagingAgent(reader);
                string outMessage = stringAgent.Resolve(message, dataAgent, "Admin");
            }
        }
        static void TestEmail()
        {
            string message = @"Hello Test Email";
            EmailManager.Instance.Send("asif.iqbal@avanzasolutions.com", "Test Subject", message);
        }

        static void TestSMS()
        {
            string message = @"Hello Test SMS";
            SMSManager.Instance.Send("03028245884", message);
        }
    }
}
