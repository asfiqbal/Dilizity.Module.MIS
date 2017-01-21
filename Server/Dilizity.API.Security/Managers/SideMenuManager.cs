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
    public class SideMenuManager : IAbstractBusiness
    {
        private const string GET_SIDE_MENUS = "GetSideMenus";

        /// <summary>
        /// </summary>
        /// <param name="parameterBusService"></param>
        public void Do(BusService parameterBusService)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.REPORT_SCHEMA))
                {
                    List<SideMenuTree> menuStructure = new List<SideMenuTree>();

                    string loginId = (string)parameterBusService.Get(GlobalConstants.LOGIN_ID);
                    if (string.IsNullOrEmpty(loginId))
                        throw new NullReferenceException("UserId can't be Null or Empty");

                    foreach (dynamic userMenu in dataLayer.ExecuteUsingKey(GET_SIDE_MENUS, GlobalConstants.LOGIN_PARAM, loginId))
                    {
                        SideMenuTree menuTree = new SideMenuTree();
                        menuTree.Id = userMenu.Id;
                        menuTree.ParentId = userMenu.ParentId;
                        if (userMenu.ParentId == 0)
                        {
                            menuTree.title = userMenu.MenuName;
                            menuTree.styleClass = userMenu.StyleClass;
                            menuTree.actionURL = null;
                            menuTree.menuTitle = null;
                        }
                        else
                        {
                            menuTree.actionURL = userMenu.Url;
                            menuTree.menuTitle = userMenu.MenuName;
                            menuTree.title = null;
                            menuTree.styleClass = null;
                        }

                        menuStructure.Add(menuTree);
                    }

                    Generate(menuStructure);

                    parameterBusService.Add(GlobalConstants.OUT_RESULT, menuStructure);
                    parameterBusService.Add(GlobalConstants.OUT_FUNCTION_STATUS, GlobalConstants.SUCCESS);
                }
            }
        }

        private void Generate(List<SideMenuTree>  tree)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                Dictionary<int, SideMenuTree> dict = tree.ToDictionary(menu => menu.Id);

                foreach (SideMenuTree menu in dict.Values)
                {
                    if (menu.ParentId != menu.Id)
                    {
                        if (menu.ParentId != 0)
                        {
                            SideMenuTree parent = dict[menu.ParentId];
                            if (parent.content == null)
                            {
                                parent.content = new List<SideMenuTree>();
                            }
                            parent.content.Add(menu);
                            tree.Remove(menu);
                        }
                    }
                }
            }
        }

    }
}