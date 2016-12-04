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
            //TestSMS();
            TestExecuteUsingKeyAndModel();
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

        static void TestExecuteUsingKeyAndModel()
        {
            QueryDTO queryDTO = new QueryDTO();
            queryDTO.Provider = @"System.Data.SqlClient";
            queryDTO.DataSource = "Server=.;Database=ReportMIS;User Id=sa;Password=Avanza123;Connection Timeout=10;"; 
            queryDTO.Sql = @"SELECT   U.USER_ID, U.NAME, P.PERMISSION_NAME, IS_SUCCESS, DATA, A.CREATED_ON
                                FROM    SEC_AUDIT A
                                INNER JOIN SEC_USER U ON A.USER_ID = U.USER_ID
                                INNER JOIN SEC_PERMISSION P ON A.PERMISSION_ID = P.PERMISSION_ID
                                WHERE(U.USER_ID = @USER_ID OR @USER_ID = -1)
                                AND(A.PERMISSION_ID = @PERMISSION_ID OR @PERMISSION_ID = -1)
                                AND A.CREATED_ON BETWEEN @FROM_DATE AND @TO_DATE";
            queryDTO.ParamCollection = new Dictionary<string, SqlParamDTO>();
            SqlParamDTO sqlParam = new SqlParamDTO();
            sqlParam.DBType = System.Data.DbType.DateTime;
            sqlParam.Name = "FROM_DATE";
            sqlParam.Size = 0;
            queryDTO.ParamCollection.Add("FROM_DATE", sqlParam);
            sqlParam = new SqlParamDTO();
            sqlParam.DBType = System.Data.DbType.DateTime;
            sqlParam.Name = "TO_DATE";
            sqlParam.Size = 0;
            queryDTO.ParamCollection.Add("TO_DATE", sqlParam);
            sqlParam = new SqlParamDTO();
            sqlParam.DBType = System.Data.DbType.Int32;
            sqlParam.Name = "USER_ID";
            sqlParam.Size = 0;
            queryDTO.ParamCollection.Add("USER_ID", sqlParam);
            sqlParam = new SqlParamDTO();
            sqlParam.DBType = System.Data.DbType.Int32;
            sqlParam.Name = "PERMISSION_ID";
            sqlParam.Size = 0;
            queryDTO.ParamCollection.Add("PERMISSION_ID", sqlParam);

            Dictionary<string, object> parameters = new Dictionary<string, object>();
            parameters["FROM_DATE"] = "2015-12-03T19:00:00.000Z";
            parameters["TO_DATE"] = "2016-12-03T19:00:00.000Z";
            parameters["USER_ID"] = "1";
            parameters["PERMISSION_ID"] = "2";

            using (var dataLayer = new DynamicDataLayer(queryDTO.Provider, queryDTO.DataSource))
            {
                //IEnumerable<dynamic> outList = dataLayer.ExecuteUsingKeyAndModel(queryDTO, parameters);
                foreach (var n in dataLayer.ExecuteUsingKeyAndModel(queryDTO, parameters, null))
                {
                    Console.WriteLine(n);
                }
            }
        }
    }
}
