using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Dilizity.Core.Util;
using Dilizity.Core.DAL;
using Dilizity.Business.Common.Services;
using Dilizity.Business.Common;

namespace ilizity.Business.Common.Model
{
    public class OperationStatus
    {
        public const string INITIATED = "Initiated";
        public const string INPROCESS = "InProcess";
        public const string SUCCESS = "Success";
        public const string FAILED = "Failed";
    }
    public class Operation
    {
        public Operation(int? parentOperationId, string permissionName, string permissionClass, string status, int errorCode, string inputParams,string updatedBy)
        {
            ParentOperationId = parentOperationId;
            PermissionName = permissionName;
            PermissionClass = permissionClass;
            Status = status;
            ErrorCode = errorCode;
            InputParams = inputParams;
            UpdatedBy = updatedBy;
        }

        public Operation(BusService parameterBusService)
        {
            //ParentOperationId = parentOperationId;
            PermissionName = (string)parameterBusService.Get(GlobalConstants.PERMISSION);
            UpdatedBy = (string)parameterBusService.Get(GlobalConstants.LOGIN_ID);
            if (parameterBusService.IsKeyPresent(GlobalConstants.OPERATION_ID))
            {
                Operation parentOperation = (Operation)parameterBusService.Get(GlobalConstants.OPERATION_ID);
                ParentOperationId = parentOperation.OperationId;
            }
            InputParams = parameterBusService.Get(GlobalConstants.IN_PARAM).ToString();

            Status = OperationStatus.INITIATED;
            ErrorCode = -1;
        }

        private const string INSERT_OPERATION = "InsertOperation";
        private const string UPDATE_OPERATION = "UpdateOperation";
        public int OperationId { get; set; }

        public int? ParentOperationId { get; set; }

        public string PermissionName { get; set; }
        public string PermissionClass { get; set; }
        public string InputParams { get; set; }

        public string Status { get; set; }

        public int ErrorCode { get; set; }

        public string UpdatedBy { get; set; }

        internal void Insert()
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                {
                    //var _t = DynamicExtensions.ToDynamic<Operation>(this);


                    Object _t =  dataLayer.ExecuteScalarUsingKey(INSERT_OPERATION, "ParentOperationId", ParentOperationId, "PermissionName", PermissionName, "PermissionClass", PermissionClass, "InputParams", InputParams, "Status", Status, "ErrorCode", ErrorCode, "UpdatedBy", UpdatedBy);
                    OperationId = Convert.ToInt32(_t);
                }

            }
        }

        internal void Update()
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                {
                    dataLayer.ExecuteScalarUsingKey(UPDATE_OPERATION, "OperationId", OperationId, "Status", Status, "ErrorCode", ErrorCode, "InputParams", InputParams);
                }
            }
        }

        public void saveToDB()
        {
            if (OperationId > 0)
                Update();
            else
                Insert();

        }
    }
}
