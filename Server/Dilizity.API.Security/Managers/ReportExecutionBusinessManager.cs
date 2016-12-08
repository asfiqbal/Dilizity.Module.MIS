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
using Newtonsoft.Json.Linq;

namespace Dilizity.API.Security.Managers
{

    public class ReportExecutionBusinessManager : IAbstractBusiness
    {
        private const string GET_REPORT_QUERY_AND_CONNECTION_STRING = "GetReportQueryAndConnectionString";
        private const string GET_REPORT_FILTERS = "GetReportFilters";
        private const string GET_REPORT_COLUMNS = "GetReportColumns";
        

        public void Do(BusService parameterBusService)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                JObject metaReportExecutionRequestObject = (JObject)parameterBusService.Get(GlobalConstants.IN_PARAM);
                string LoginId = (string)parameterBusService.Get(GlobalConstants.LOGIN_ID);
                string permissionId = (string)metaReportExecutionRequestObject["PermissionId"].ToString();
                int reportId = int.Parse(metaReportExecutionRequestObject["ReportId"].ToString());

                JObject fieldCollection = (JObject)metaReportExecutionRequestObject["fieldCollection"];

                Dictionary<string, object> fieldCollectionDict = fieldCollection.ToObject<Dictionary<string, object>>();
                QueryDTO queryDTO = GetQueryDTO(reportId);
                Dictionary<string, object> columnCollection = GetReportColumns(reportId);
                List<dynamic> outList = ExecuteQueryDTO(queryDTO, fieldCollectionDict, columnCollection);

                AuditHelper.Register(parameterBusService, LoginId, permissionId, GlobalConstants.SUCCESS, metaReportExecutionRequestObject.ToString());
                parameterBusService.Add(GlobalConstants.OUT_RESULT, outList);
                parameterBusService.Add(GlobalConstants.OUT_FUNCTION_STATUS, GlobalConstants.SUCCESS);
            }
        }

        private QueryDTO GetQueryDTO(int reportId)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.REPORT_SCHEMA))
                {
                    dynamic reportObject = dataLayer.ExecuteAndGetSingleRowUsingKey(GET_REPORT_QUERY_AND_CONNECTION_STRING, "ReportId", reportId);
                    string connectionString = Utility.Decrypt(reportObject.ConnectionString, false);

                    QueryDTO queryDTO = new QueryDTO();
                    queryDTO.DataSource = connectionString;
                    queryDTO.Sql = reportObject.Query;
                    queryDTO.Provider = reportObject.ProviderName;
                    queryDTO.ParamCollection = new Dictionary<string, SqlParamDTO>();

                    foreach (dynamic whereCondition in dataLayer.ExecuteUsingKey(GET_REPORT_FILTERS, "ReportId", reportId))
                    {
                        SqlParamDTO sqlParamDTO = new SqlParamDTO();
                        sqlParamDTO.Name = whereCondition.FilterName;
                        Type T = Type.GetType(whereCondition.DataType);
                        sqlParamDTO.DBType = SqlMapper.ToDbType(T);
                        sqlParamDTO.Size = whereCondition.Size;
                        queryDTO.ParamCollection.Add(sqlParamDTO.Name, sqlParamDTO);
                    }
                    return queryDTO;
                }
            }
        }

        private Dictionary<string, object> GetReportColumns(int reportId)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                Dictionary<string, object> dictColumns = new Dictionary<string, object>();
                using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.REPORT_SCHEMA))
                {
                    foreach (dynamic columnObject in dataLayer.ExecuteUsingKey(GET_REPORT_COLUMNS, "ReportId", reportId))
                    {
                        ReportColumnDTO tcolumnObject = new ReportColumnDTO(columnObject.ColumnName, columnObject.DisplayName, columnObject.ColumnPermissionName, columnObject.MaskingFilter);

                        dictColumns[columnObject.ColumnName] = tcolumnObject;

                    }
                    return dictColumns;
                }
            }
        }


        private List<dynamic> ExecuteQueryDTO(QueryDTO queryDTO, Dictionary<string, object> parameters, Dictionary<string, object> tcolumnCollection)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                using (DynamicDataLayer dataLayer = new DynamicDataLayer(queryDTO.Provider, queryDTO.DataSource))
                {
                    IEnumerable<dynamic> outList = dataLayer.ExecuteUsingKeyAndModel(queryDTO, parameters, tcolumnCollection);
                    return outList.ToList<dynamic>();
                }
            }
        }
    }
}