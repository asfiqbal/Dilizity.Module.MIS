using Dilizity.Business.Common;
using Dilizity.Business.Common.Services;
using Dilizity.Core.DAL;
using Dilizity.Core.Util;
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
            try
            {
                using (FnTraceWrap tracer = new FnTraceWrap())
                {
                    using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                    {
                        List<string> permissions = (List<string>)parameterBusService.Get(GlobalConstants.PERMISSIONS);
                        string permission = permissions[0];
                        foreach (dynamic businessAction in dataLayer.ExecuteUsingKey(GET_WORKFLOW_ACTIONS, "Permission", permission))
                        {
                            string binPath = System.IO.Path.Combine(System.AppDomain.CurrentDomain.BaseDirectory, "bin"); // note: don't use CurrentEntryAssembly or anything like that.
                            Log.Error(this.GetType(), binPath + @"/" + businessAction.SystemAssembly+"|"+ businessAction.SystemType);

                            Assembly businessModule = Assembly.LoadFrom(binPath + @"/"+ businessAction.SystemAssembly);

                            Type systemtype = businessModule.GetType(businessAction.SystemType);
                            dynamic businessObject = Activator.CreateInstance(systemtype);
                            businessObject.Do(parameterBusService);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Log.Error(this.GetType(), ex.Message, ex);
                throw ex;
            }
        }
    }
}
