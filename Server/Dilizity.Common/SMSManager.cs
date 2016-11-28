using Dilizity.Core.DAL;
using Dilizity.Core.Util;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;

namespace Dilizity.Business.Common
{
    public class SMSManager
    {
        private static volatile SMSManager instance;
        private static string SMSServerURL = string.Empty;


        private SMSManager()  {}

        public static SMSManager Instance
        {
            get
            {
                if (instance == null)
                {
                    lock (SMSServerURL)
                    {
                        if (instance == null)
                            instance = new SMSManager();
                        instance.Read();
                    }
                }

                return instance;
            }
        }

        private bool Read()
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                string schema = ConfigurationManager.AppSettings["Schema"];

                using (DynamicDataLayer dataLayer = new DynamicDataLayer(schema))
                {
                    dynamic SMTPSettings = dataLayer.ExecuteAndGetSingleRowUsingKey("GetSMSSettings");
                    SMSServerURL = SMTPSettings.SMSServerURL;
                    Log.Debug(this.GetType(), SMSServerURL);
                    return true;
                }
            }
        }

        public void Send(string toMobileNumber, string message)
        {
            using (FnTraceWrap tracer = new FnTraceWrap(toMobileNumber, message))
            {
                try
                {
                    string finalMessage = SMSServerURL.Replace("{MOBILE_NUMBER}", toMobileNumber);
                    finalMessage = finalMessage.Replace("{MESSAGE}", message);
                    HttpWebRequest client = (HttpWebRequest)WebRequest.Create(finalMessage);
                    HttpWebResponse response = (HttpWebResponse)client.GetResponse();
                    Log.Debug(this.GetType(), string.Format("response status Code: {0}", response.StatusCode));
                }
                catch (Exception ex)
                {
                    Log.Error(this.GetType(), ex.Message, ex);
                }
            }
        }

    }
}