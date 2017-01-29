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
                ReportMetaData outMetaFields = new ReportMetaData();
                outMetaFields.fieldCollection = new List<ReportMetaFields>();
                ReportMetaFields metaFields = new ReportMetaFields();
                outMetaFields.fieldCollection.Add(metaFields);

                //List<ReportMetaFields> listReportMetaData = new List<ReportMetaFields>();
                //ReportMetaFields reportMetaDataOutObject = new ReportMetaFields();
                ReportMetaDataRequest metaDataRequest = (ReportMetaDataRequest)parameterBusService.Get(GlobalConstants.IN_PARAM);
                PopulateReportMetaData(metaDataRequest, outMetaFields);
                PopulateReportMetaFiltersData(metaDataRequest, metaFields);
                AuditHelper.Register(parameterBusService, metaDataRequest.LoginId, metaDataRequest.PermissionId, GlobalConstants.SUCCESS, metaDataRequest.ToString());
                parameterBusService.Add(GlobalConstants.OUT_RESULT, outMetaFields);
                parameterBusService[GlobalConstants.OUT_FUNCTION_ERROR_CODE] = GlobalErrorCodes.Success;
            }
        }

        private void PopulateReportMetaData(ReportMetaDataRequest metaDataRequest, ReportMetaData reportMetaDataOutObject)
        {
            using (FnTraceWrap tracer = new FnTraceWrap("LoginId", metaDataRequest.LoginId, "ReportId", metaDataRequest.ReportId))
            {
                using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.REPORT_SCHEMA))
                {
                    dynamic reportInfo = dataLayer.ExecuteAndGetSingleRowUsingKey(GET_REPORT_META_SCREEN_INFO, "LoginId", metaDataRequest.LoginId, "ReportId", metaDataRequest.ReportId);
                    reportMetaDataOutObject.fieldCollection[0].className = reportInfo.ClassName;
                    Log.Debug(typeof(ReportMetaDataBusinessManager), reportInfo.DisplayName);
                    reportMetaDataOutObject.DisplayName = reportInfo.DisplayName;
                    reportMetaDataOutObject.ReportId = reportInfo.ReportId;
                    reportMetaDataOutObject.PermissionName = reportInfo.PermissionName;
                }
            }
        }

        private void PopulateReportMetaFiltersData(ReportMetaDataRequest metaDataRequest, ReportMetaFields reportMetaDataOutObject)
        {
            using (FnTraceWrap tracer = new FnTraceWrap("LoginId", metaDataRequest.LoginId, "ReportId", metaDataRequest.ReportId))
            {
                using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.REPORT_SCHEMA))
                {
                    reportMetaDataOutObject.fieldGroup = new List<ReportMetaFiltersData>();
                    foreach (dynamic reportFilters in dataLayer.ExecuteUsingKey(GET_REPORT_META_FILTERS_INFO, "ReportId", metaDataRequest.ReportId))
                    {
                        ReportMetaFiltersData metafilterData = new ReportMetaFiltersData();
                        string filterDataSourceQuery = string.Empty;
                        string filterDataConnectionString = string.Empty;
                        metafilterData.key = reportFilters.FilterName;
                        Log.Debug(typeof(ReportMetaDataBusinessManager), reportFilters.FilterName);
                        metafilterData.type = reportFilters.FilterType;
                        metafilterData.className = reportFilters.ClassName;
                        metafilterData.templateOptions.label = reportFilters.DispayName;
                        metafilterData.templateOptions.type = reportFilters.TemplateOptionType;
                        metafilterData.templateOptions.placeholder = reportFilters.PlaceHolder;
                        metafilterData.templateOptions.datepickerPopup = reportFilters.DatepickerPopup;
                        metafilterData.templateOptions.required = (reportFilters.IsMandatory == 1) ? true : false;
                        metafilterData.templateOptions.defaultValue = reportFilters.DefaultValue;
                        if (!string.IsNullOrEmpty(reportFilters.FilterConnectionString) && !string.IsNullOrEmpty(reportFilters.FilterDataSourceQuery))
                        {
                            metafilterData.templateOptions.options = GetSelectionFilterDataFromRemoteConnection(reportFilters.ProviderName, reportFilters.FilterConnectionString, reportFilters.FilterDataSourceQuery);
                        }
                        reportMetaDataOutObject.fieldGroup.Add(metafilterData);
                    }
                }
            }
        }


        private List<ReportSelectionControlData> GetSelectionFilterDataFromRemoteConnection(string remoteProviderName, string remoteConnectionString, string remoteSQL)
        {
            using (FnTraceWrap tracer = new FnTraceWrap("remoteProviderName", remoteProviderName, "remoteConnectionString", remoteConnectionString, "remoteSQL", remoteSQL))
            {
                string decryptConnectionString = Utility.Decrypt(remoteConnectionString, false);
                using (DynamicDataLayer dataLayer = new DynamicDataLayer(remoteProviderName, decryptConnectionString))
                {
                    List<ReportSelectionControlData> selectionControlList = new List<ReportSelectionControlData>();
                    foreach (dynamic keyValue in dataLayer.ExecuteText(remoteSQL))
                    {
                        ReportSelectionControlData selectionControl = new ReportSelectionControlData();
                        selectionControl.value  = keyValue.Id.ToString();
                        selectionControl.name = keyValue.Value.ToString();
                        selectionControlList.Add(selectionControl);
                    }
                    return selectionControlList;
                }
            }
        }
    }
}