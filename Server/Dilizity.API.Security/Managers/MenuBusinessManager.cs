﻿using System;
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
    public class MenuBusinessManager : IAbstractBusiness
    {
        private const string GET_USER_MENUS = "GetMenus";
        private const string GET_USER = "GetUser";


        public void Do(BusService parameterBusService)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                List<MenuTree> menuStructure = new List<MenuTree>();

                dynamic outResult = new ExpandoObject();

                string loginId = (string)parameterBusService.Get(GlobalConstants.LOGIN_ID);
                if (string.IsNullOrEmpty(loginId))
                    throw new NullReferenceException("UserId can't be Null or Empty");

                using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.REPORT_SCHEMA))
                {

                    dynamic secUser = dataLayer.ExecuteAndGetSingleRowUsingKey(GET_USER, GlobalConstants.LOGIN_PARAM, loginId);

                    outResult.Name = secUser.Name;
                    outResult.Picture = secUser.Picture;

                    foreach (dynamic userMenu in dataLayer.ExecuteUsingKey(GET_USER_MENUS, "LoginId", loginId))
                    {
                        MenuTree menuTree = new MenuTree();
                        menuTree.Id = userMenu.Id;
                        menuTree.ParentId = userMenu.ParentId;
                        menuTree.name = userMenu.MenuName;
                        menuTree.link = userMenu.Url;
                        menuStructure.Add(menuTree);
                    }
                }

                Generate(menuStructure);

                outResult.Menus = menuStructure;

                parameterBusService.Add(GlobalConstants.OUT_RESULT, outResult);
                parameterBusService[GlobalConstants.OUT_FUNCTION_ERROR_CODE] = GlobalErrorCodes.Success;

            }
        }

        private void Generate(List<MenuTree>  tree)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.REPORT_SCHEMA))
                {
                    Dictionary<int, MenuTree> dict = tree.ToDictionary(menu => menu.Id);

                    foreach (MenuTree menu in dict.Values)
                    {
                        if (menu.ParentId != menu.Id)
                        {
                            if (menu.ParentId != 0)
                            {
                                MenuTree parent = dict[menu.ParentId];
                                if (parent.subtree == null)
                                {
                                    parent.subtree = new List<MenuTree>();
                                }
                                parent.subtree.Add(menu);
                                tree.Remove(menu);
                            }
                        }
                    }
                }
            }
        }

    }
}