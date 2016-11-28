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

namespace Dilizity.API.Security.Managers
{

    public class ReportMetaDataBusinessManager : IAbstractBusiness
    {
        private const string GET_REPORT_META_SCREEN_INFO = "GetReportMetaScreenInfo";
        private const string GET_REPORT_META_FILTERS_INFO = "GetReportMetaFiltersInfo";

        public void Do(BusService parameterBusService)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                ReportMetaData reportMetaDataOutObject = new ReportMetaData();
                ReportMetaDataRequest metaDataRequest = (ReportMetaDataRequest)parameterBusService.Get(GlobalConstants.IN_PARAM);
                PopulateReportMetaData(metaDataRequest, reportMetaDataOutObject);
                PopulateReportMetaFiltersData(metaDataRequest, reportMetaDataOutObject);

                AuditHelper.Register(parameterBusService, metaDataRequest.LoginId, metaDataRequest.PermissionId, GlobalConstants.SUCCESS, metaDataRequest.ToString());
                parameterBusService.Add("OUT_RESULT", reportMetaDataOutObject);
            }
        }

        private void PopulateReportMetaFiltersData(ReportMetaDataRequest metaDataRequest, ReportMetaData reportMetaDataOutObject)
        {
            using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.REPORT_SCHEMA))
            {
                dynamic reportInfo = dataLayer.ExecuteAndGetSingleRowUsingKey(GET_REPORT_META_SCREEN_INFO, "LoginId", metaDataRequest.LoginId, "ReportId", metaDataRequest.ReportId);
                reportMetaDataOutObject.DisplayName = reportInfo.DisplayName;
                reportMetaDataOutObject.ReportId = reportInfo.ReportId;
                reportMetaDataOutObject.PermissionId = reportInfo.ReportPermissionId;
            }
        }

        private void PopulateReportMetaData(ReportMetaDataRequest metaDataRequest, ReportMetaData reportMetaDataOutObject)
        {
            using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.REPORT_SCHEMA))
            {
                List<ReportMetaFiltersData> filtersList = new List<ReportMetaFiltersData>();
                foreach (dynamic reportFilters in dataLayer.ExecuteUsingKey(GET_REPORT_META_FILTERS_INFO, "ReportId", metaDataRequest.ReportId))
                {

                }
                //reportMetaDataOutObject.Filters = new List<ReportMetaFiltersData>();
            }
        }
}