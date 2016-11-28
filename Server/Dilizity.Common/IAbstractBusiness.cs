using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dilizity.Business.Common.Services;

namespace Dilizity.Business.Common
{
    public interface IAbstractBusiness
    {
        void Do(BusService busService);
    }
}
