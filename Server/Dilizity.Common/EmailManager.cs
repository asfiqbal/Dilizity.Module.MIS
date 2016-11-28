using Dilizity.Core.DAL;
using Dilizity.Core.Util;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Mail;
using System.Text;

namespace Dilizity.Business.Common
{
    public class EmailManager
    {
        private static volatile EmailManager instance;
        private static string SMTPServer = string.Empty;
        private static string SMTPServerFromAddress = string.Empty;
        private static string SMTPServerUserId = string.Empty;
        private static string SMTPServerPassword = string.Empty;
        private static int SMTPServerPort = -1;
        private static bool SMTPServerEnableSSL= false;

        private EmailManager()  {}

        public static EmailManager Instance
        {
            get
            {
                if (instance == null)
                {
                    lock (SMTPServer)
                    {
                        if (instance == null)
                            instance = new EmailManager();
                        instance.Read();
                    }
                }

                return instance;
            }
        }

        private bool Read()
        {
            string schema = ConfigurationManager.AppSettings["Schema"];
            using (FnTraceWrap tracer = new FnTraceWrap(schema))
            {
                using (DynamicDataLayer dataLayer = new DynamicDataLayer(schema))
                {
                    dynamic SMTPSettings = dataLayer.ExecuteAndGetSingleRowUsingKey("GetSMTPSettings");
                    SMTPServer = SMTPSettings.SMTPServer;
                    SMTPServerFromAddress = SMTPSettings.SMTPServerFromAddress;
                    SMTPServerUserId = SMTPSettings.SMTPServerUserId;
                    SMTPServerPassword = Utility.Decrypt(SMTPSettings.SMTPServerPassword, false);
                    SMTPServerPort = int.Parse(SMTPSettings.SMTPServerPort);
                    SMTPServerEnableSSL = bool.Parse(SMTPSettings.SMTPServerEnableSSL);
                    Log.Debug(this.GetType(), SMTPServer, SMTPServerFromAddress, SMTPServerUserId, Utility.GetSecureString(SMTPServerPassword), SMTPServerPort, SMTPServerEnableSSL);
                    return true;
                }
            }
        }

        public void Send(string toAddress, string subject, string body)
        {
            using (FnTraceWrap tracer = new FnTraceWrap(toAddress, subject, body))
            {
                try
                {
                    using (MailMessage mail = new MailMessage())
                    {
                        using (SmtpClient smtpClient = new SmtpClient(SMTPServer))
                        {
                            mail.From = new MailAddress(SMTPServerFromAddress);
                            mail.To.Add(toAddress);
                            mail.Subject = subject;

                            mail.IsBodyHtml = true;

                            mail.Body = body;

                            smtpClient.Port = SMTPServerPort;
                            smtpClient.Credentials = new System.Net.NetworkCredential(SMTPServerUserId, SMTPServerPassword);
                            smtpClient.EnableSsl = SMTPServerEnableSSL;
                            smtpClient.Timeout = 10;
                            smtpClient.Send(mail);
                            Log.Debug(this.GetType(),"Email Sent Successfully");
                        }
                    }
                }
                catch (Exception ex)
                {
                    Log.Error(this.GetType(), ex.Message, ex);
                }
            }
        }

        public void Send(string toAddress, string subject, string body, string filePath)
        {
            using (FnTraceWrap tracer = new FnTraceWrap(toAddress, subject, body, filePath))
            {
                try
                {
                    using (MailMessage mail = new MailMessage())
                    {
                        using (SmtpClient SmtpServer = new SmtpClient(SMTPServer))
                        {
                            mail.From = new MailAddress(SMTPServerFromAddress);
                            mail.To.Add(toAddress);
                            mail.Subject = subject;

                            mail.IsBodyHtml = true;

                            mail.Body = body;

                            if (filePath.Length > 0)
                            {
                                mail.Attachments.Add(new Attachment(filePath));
                            }

                            SmtpServer.Port = SMTPServerPort;
                            SmtpServer.Credentials = new System.Net.NetworkCredential(SMTPServerUserId, SMTPServerPassword);
                            SmtpServer.EnableSsl = SMTPServerEnableSSL;

                            SmtpServer.Send(mail);
                            Log.Debug(this.GetType(), "Email Sent Successfully");
                        }
                    }
                }
                catch (Exception ex)
                {
                    Log.Error(this.GetType(), ex.Message, ex);
                }
            }
        }

    }
}