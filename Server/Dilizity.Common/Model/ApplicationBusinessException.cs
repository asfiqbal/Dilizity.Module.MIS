using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Dilizity.Business.Common.Model
{

    [Serializable]
    public class ApplicationBusinessException : Exception
    {
        public int ErrorCode { get; private  set; }

        public ApplicationBusinessException()
            : base()
        { }

        public ApplicationBusinessException(int errorCode) : base()
        {
            ErrorCode = errorCode;
        }

        public ApplicationBusinessException(string message) : base(message)
        {
        }

        public ApplicationBusinessException(string format, params object[] args)
            : base(string.Format(format, args))
        {
        }

        public ApplicationBusinessException( string message, Exception innerException)
            : base(message, innerException)
        {
        }

        public ApplicationBusinessException(string format, Exception innerException, params object[] args)
            : base(string.Format(format, args), innerException)
        { }

        protected ApplicationBusinessException(SerializationInfo info, StreamingContext context)
            : base(info, context)
        { }
    }
}
