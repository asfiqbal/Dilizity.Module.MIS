using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Reflection;
using System.Text;

namespace Dilizity.Core.Util
{
    // This class traces function entry/exit
    // Constructor is used to automatically log function entry.
    // Dispose is used to automatically log function exit.
    // use "using(FnTraceWrap x = new FnTraceWrap()){ function code }" pattern for function entry/exit tracing
    public class FnTraceWrap : IDisposable
    {
        string methodName;
        string className;
        Type classType;

        private bool _disposed = false;

        public FnTraceWrap()
        {
            StackFrame frame;
            MethodBase method;
            frame = new StackFrame(1);
            method = frame.GetMethod();
            this.classType = method.GetType();
            this.methodName = method.Name;
            this.className = method.DeclaringType.Name;

            Log.Debug(this.classType, "{0}.{1} - Begin", this.className, this.methodName);
        }

        public FnTraceWrap(params object[] args)
        {
            StackFrame frame;
            MethodBase method;
            frame = new StackFrame(1);
            method = frame.GetMethod();
            this.classType = method.GetType();
            this.methodName = method.Name;
            this.className = method.DeclaringType.Name;

            string parameters = String.Join("|", args);

            Log.Debug(this.classType, "{0}.{1} - Begin ({2})", this.className, this.methodName, parameters);
        }

        public void TraceMessage(string format, params object[] args)
        {
            string message = String.Format(format, args);
            
            Log.Debug(this.classType, message);
        }

        public void Dispose()
        {
            if (!this._disposed)
            {
                this._disposed = true;
                //MyEventSourceClass.Log.TraceExit(this.className, this.methodName);
                Log.Debug(this.classType, "{0}.{1} - End", this.className, this.methodName);
            }
        }
    }

}
