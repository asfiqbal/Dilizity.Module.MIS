using Dilizity.API.Security.Models;
using Dilizity.Business.Common;
using Dilizity.Business.Common.Model;
using Dilizity.Business.Common.Services;
using Dilizity.Core.DAL;
using Dilizity.Core.Util;
using ilizity.Business.Common.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace Dilizity.API.Security.Managers
{
    public class WorkFlowActionManager : IAbstractBusiness
    {
        private const string GET_WORKFLOW_ACTIONS = "GetWorkFlowActions";

        public void Do(BusService parameterBusService)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                Operation op = null;
                try
                {
                    op = new Operation(parameterBusService);
                    op.PermissionClass = typeof(WorkFlowActionManager).ToString();
                    op.saveToDB();
                    parameterBusService.Add(GlobalConstants.OPERATION_ID, op);
                    DoOnSuccess(parameterBusService);
                    op.Status = GlobalConstants.SUCCESS;
                    op.saveToDB();
                }
                catch(Exception ex)
                {
                    Log.Error(this.GetType(), ex.Message, ex);
                    op.Status = GlobalConstants.FAILURE;
                    op.saveToDB();
                    DoBoth(parameterBusService, ExecutionBehavior.OnFailure);
                }
                finally
                {
                    DoBoth(parameterBusService, ExecutionBehavior.OnBoth);
                }
            }
        }

        private void DoOnSuccess(BusService parameterBusService)
        {
            try
            {
                using (FnTraceWrap tracer = new FnTraceWrap())
                {
                    using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                    {
                        string permission = (string)parameterBusService.Get(GlobalConstants.PERMISSION);
                        foreach (dynamic businessAction in dataLayer.ExecuteUsingKey(GET_WORKFLOW_ACTIONS, "Permission", permission, "ExecutionBehavior", ExecutionBehavior.OnSuccess))
                        {
                            string binPath = System.IO.Path.Combine(System.AppDomain.CurrentDomain.BaseDirectory, "bin"); // note: don't use CurrentEntryAssembly or anything like that.
                            Log.Debug(this.GetType(), binPath + @"/" + businessAction.SystemAssembly + "|" + businessAction.SystemType);

                            Assembly businessModule = Assembly.LoadFrom(binPath + @"/" + businessAction.SystemAssembly);
                            int isErrorTolerant = businessAction.IsErrorTolerant;
                            Type systemtype = businessModule.GetType(businessAction.SystemType);
                            dynamic businessObject = Activator.CreateInstance(systemtype);
                            if (isErrorTolerant == 0)
                            {
                                businessObject.Do(parameterBusService);
                            }
                            else
                            {
                                try
                                {
                                    businessObject.Do(parameterBusService);
                                }
                                catch (Exception ex)
                                {
                                    Log.Error(this.GetType(), ex.Message, ex);
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Log.Error(this.GetType(), ex.Message, ex);
                parameterBusService.Add(GlobalConstants.OUT_FUNCTION_STATUS, GlobalConstants.FAILURE);
                throw ex;
            }
        }

        private void DoBoth(BusService parameterBusService, ExecutionBehavior behavior)
        {
            try
            {
                using (FnTraceWrap tracer = new FnTraceWrap(behavior))
                {
                    using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                    {
                        string permission = (string)parameterBusService.Get(GlobalConstants.PERMISSION);
                        foreach (dynamic businessAction in dataLayer.ExecuteUsingKey(GET_WORKFLOW_ACTIONS, "Permission", permission, "ExecutionBehavior", behavior))
                        {
                            string binPath = System.IO.Path.Combine(System.AppDomain.CurrentDomain.BaseDirectory, "bin"); // note: don't use CurrentEntryAssembly or anything like that.
                            Log.Error(this.GetType(), binPath + @"/" + businessAction.SystemAssembly + "|" + businessAction.SystemType);

                            Assembly businessModule = Assembly.LoadFrom(binPath + @"/" + businessAction.SystemAssembly);

                            Type systemtype = businessModule.GetType(businessAction.SystemType);
                            dynamic businessObject = Activator.CreateInstance(systemtype);
                            try {
                                businessObject.Do(parameterBusService);
                            }
                            catch(Exception ex)
                            {
                                Log.Error(this.GetType(), ex.Message, ex);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Log.Error(this.GetType(), ex.Message, ex);
                throw;
            }
        }


    }
}
