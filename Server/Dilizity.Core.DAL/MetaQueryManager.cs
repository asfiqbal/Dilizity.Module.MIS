using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using Dilizity.Core;
using Dilizity.Core.Util;

namespace Dilizity.Core.DAL
{
    public class MetaQueryManager
    {
        private static volatile MetaQueryManager instance;
        private static Dictionary<string, QueryDTO> queriesCollection = new Dictionary<string, QueryDTO>();
        private static Dictionary<string, SchemaDTO> schemaCollection = new Dictionary<string, SchemaDTO>();

        //public string Provider { get; set; }
        //public string schemaConnectionString
        //{
        //    get;
        //    set;
        //}

        private MetaQueryManager() { }

        public static MetaQueryManager Instance
        {
            get
            {
                if (instance == null)
                {
                    lock (queriesCollection)
                    {
                        if (instance == null)
                            instance = new MetaQueryManager();
                        instance.Read();
                    }
                }

                return instance;
            }
        }

        public bool Read()
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                XmlDocument xmlDocument = new XmlDocument();
                string metadataPath = ConfigReader.Instance.Settings("MetaDataLocation");

                Log.Debug(this.GetType(), "metadataPath={0}", metadataPath);
                xmlDocument.Load(metadataPath);
                XmlNodeList schemaNodesList = xmlDocument.SelectNodes(@"/root/Schema");
                foreach (XmlNode schemaNode in schemaNodesList)
                {
                    SchemaDTO schemaDTO = new SchemaDTO();

                    schemaDTO.Name = schemaNode.Attributes["Name"].Value;
                    schemaDTO.DataSource = schemaNode.Attributes["DataSource"].Value;
                    schemaDTO.ProviderName = schemaNode.Attributes["Provider"].Value;

                    Log.Debug(this.GetType(), "schemaConnectionString={0}", schemaDTO.DataSource);
                    Log.Debug(this.GetType(), "provider={0}", schemaDTO.ProviderName);

                    XmlNodeList nodeList = xmlDocument.SelectNodes(@"/root/Schema/Query");
                    foreach (XmlNode queryNode in nodeList)
                    {
                        QueryDTO queryDTO = new QueryDTO();
                        queryDTO.ID = queryNode.Attributes["ID"].Value;
                        queryDTO.DataSource = schemaDTO.DataSource;
                        queryDTO.Provider = schemaDTO.ProviderName;
                        Log.Debug(this.GetType(), "queryDTO.ID={0}", queryDTO.ID);
                        queryDTO.Sql = queryNode.InnerText;

                        XmlNodeList paramCollection = queryNode.SelectNodes("Param");
                        foreach (XmlNode paramNode in paramCollection)
                        {
                            SqlParamDTO paramDTO = new SqlParamDTO();
                            paramDTO.Name = paramNode.Attributes["Name"].Value;
                            Log.Debug(this.GetType(), "paramDTO.Name={0}", paramDTO.Name);
                            string type = paramNode.Attributes["Type"].Value;
                            Log.Debug(this.GetType(), "type={0}", type);
                            Type T = Type.GetType(type);
                            Log.Debug(this.GetType(), "T={0}", T.ToString());
                            paramDTO.DBType = SqlMapper.ToDbType(T);
                            int outValue = -1;
                            int.TryParse(paramNode.Attributes["Size"].Value, out outValue);
                            Log.Debug(this.GetType(), "Size={0}", outValue);
                            paramDTO.Size = outValue;
                            queryDTO.ParamCollection[paramDTO.Name] = paramDTO;

                        }

                        queriesCollection[queryDTO.ID] = queryDTO;
                    }
                    schemaCollection[schemaDTO.Name] = schemaDTO;

                }
                return true;
            }
        }

        public SchemaDTO GetSchema(string schemaName)
        {
            return schemaCollection[schemaName];
        }

        public QueryDTO this[string key]
        {
            get
            {
                return queriesCollection[key];
            }
        }
    }
}
