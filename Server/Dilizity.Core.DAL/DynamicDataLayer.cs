using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Common;
using System.Diagnostics.Contracts;
using System.Dynamic;
using Dilizity.Core.Util;
using System.Collections;
using System.Text.RegularExpressions;

namespace Dilizity.Core.DAL
{

    public class DynamicDataLayer : IDisposable
    {
        //private bool disposeConnection = false;
        private DbConnection connection;
        private DbTransaction transaction;
        StringBuilder sqlCollection = null;

        internal bool IsDisposed { get; private set; }

        public DbTransaction Transaction
        {
            get
            {
                return transaction;
            }
        }

        public DynamicDataLayer(string schemaName)
        {
            using (FnTraceWrap tracer = new FnTraceWrap(schemaName))
            {
                Contract.Requires(!string.IsNullOrWhiteSpace(schemaName));
                SchemaDTO schemaDTO = MetaQueryManager.Instance.GetSchema(schemaName);
                
                string connectionString = schemaDTO.DataSource;
                string providerName = schemaDTO.ProviderName;

                Contract.Requires(!string.IsNullOrWhiteSpace(connectionString));
                Contract.Requires(!string.IsNullOrWhiteSpace(providerName));
                DbProviderFactory factory = DbProviderFactories.GetFactory(providerName);

                connection = factory.CreateConnection();
                connection.ConnectionString = connectionString;
                connection.Open();
                //disposeConnection = true;
            }
        }

        public DynamicDataLayer(string schemaName, bool InTransaction, bool delayExecuteScript)
        {
            using (FnTraceWrap tracer = new FnTraceWrap(schemaName))
            {
                Contract.Requires(!string.IsNullOrWhiteSpace(schemaName));
                SchemaDTO schemaDTO = MetaQueryManager.Instance.GetSchema(schemaName);

                string connectionString = schemaDTO.DataSource;
                string providerName = schemaDTO.ProviderName;

                Contract.Requires(!string.IsNullOrWhiteSpace(connectionString));
                Contract.Requires(!string.IsNullOrWhiteSpace(providerName));
                DbProviderFactory factory = DbProviderFactories.GetFactory(providerName);

                connection = factory.CreateConnection();
                connection.ConnectionString = connectionString;
                connection.Open();

                if (InTransaction)
                {
                    BeginTransaction();
                }
                if (delayExecuteScript)
                {
                    sqlCollection = new StringBuilder();
                }
                //disposeConnection = true;
            }
        }

        public DynamicDataLayer(string providerName, string connectionString)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                Contract.Requires(!string.IsNullOrWhiteSpace(providerName));
                Contract.Requires(!string.IsNullOrWhiteSpace(connectionString));

                DbProviderFactory factory = DbProviderFactories.GetFactory(providerName);

                connection = factory.CreateConnection();
                connection.ConnectionString = connectionString;
                connection.Open();
            }
        }

        public DbConnection Connection
        {
            get { return this.connection; }
        }

        public IEnumerable<dynamic> ExecuteText(string commandText, params KeyValuePair<string, object>[] parameters)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                Contract.Requires(!string.IsNullOrWhiteSpace(commandText));
                Contract.Requires(parameters != null);

                Log.Debug(this.GetType(), "SQL={0}", commandText);

                //lock (this)
                //{
                    using (var command = connection.CreateCommand())
                    {
                        command.CommandText = commandText;
                        foreach (var parameter in parameters)
                        {
                            var p = command.CreateParameter();
                            p.ParameterName = parameter.Key;
                            p.Value = parameter.Value;
                            command.Parameters.Add(p);
                        }
                        using (var reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                dynamic record = new ExpandoObject();
                                var recordMembers = (IDictionary<string, object>)record;
                                for (int i = 0; i < reader.FieldCount; i++)
                                {
                                    recordMembers.Add(reader.GetName(i), GetDefaultIfDBNull(reader.GetValue(i), reader.GetFieldType(i)));
                                }
                                yield return record;
                            }
                        }
                    }
                //}
            }
        }

        public IEnumerable<dynamic> ExecuteUsingKey(string commandKey, params object[] parameters)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                Contract.Requires(!string.IsNullOrWhiteSpace(commandKey));
                Contract.Requires(parameters != null);

                QueryDTO query = MetaQueryManager.Instance[commandKey];
                IDictionary<string, object> tmpParams = Dilizity.Core.Util.Utility.Param2Dictionary(parameters);
                Log.Debug(this.GetType(), "commandKey={0}", commandKey); 

                //lock (this)
                //{
                    using (var command = connection.CreateCommand())
                    {
                        command.CommandText = query.Sql;
                        command.CommandTimeout = Utility.ConvertStringToInt(ConfigReader.Instance.Settings("CommandTimeOut"));

                    //Log.Debug(this.GetType(), "SQL={0}", query.Sql);
                        foreach (var SqlParam in query.ParamCollection)
                        {
                            string name = SqlParam.Key;
                            SqlParamDTO sqlParamDt = SqlParam.Value;
                            var p = command.CreateParameter();
                            p.ParameterName = sqlParamDt.Name;
                            p.DbType = sqlParamDt.DBType;
                            p.Value = tmpParams[sqlParamDt.Name];
                            command.Parameters.Add(p);
                        }

                        Log.Debug(this.GetType(), "Before Calling CommandSQL={0} with connection state = {1}", query.Sql, command.Connection.State);
                        using (var reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                dynamic record = new ExpandoObject();
                                var recordMembers = (IDictionary<string, object>)record;
                                for (int i = 0; i < reader.FieldCount; i++)
                                {
                                    recordMembers.Add(reader.GetName(i), GetDefaultIfDBNull(reader.GetValue(i), reader.GetFieldType(i)));
                                }
                                yield return record;
                            }
                        }
                    }
                //}
            }
        }

        public IEnumerable<dynamic> ExecuteUsingKeyAndModel(QueryDTO queryObject, Dictionary<string, object> modelParameters, Dictionary<string, object> columnCollection)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                Contract.Requires(queryObject != null);
                Contract.Requires(!string.IsNullOrWhiteSpace(queryObject.Sql));

                Log.Debug(this.GetType(), "query={0}", queryObject.Sql);

                //lock (this)
                //{
                using (var command = connection.CreateCommand())
                {
                    command.CommandText = queryObject.Sql;
                    command.CommandTimeout = Utility.ConvertStringToInt(ConfigReader.Instance.Settings("CommandTimeOut"));

                    foreach (var SqlParam in queryObject.ParamCollection)
                    {
                        string name = SqlParam.Key;
                        SqlParamDTO sqlParamDt = SqlParam.Value;
                        var p = command.CreateParameter();
                        p.ParameterName = sqlParamDt.Name;
                        p.DbType = sqlParamDt.DBType;
                        p.Value = modelParameters[sqlParamDt.Name];
                        command.Parameters.Add(p);
                    }

                    Log.Debug(this.GetType(), "Before Calling CommandSQL={0} with connection state = {1}", queryObject.Sql, command.Connection.State);
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            dynamic record = new ExpandoObject();
                            var recordMembers = (IDictionary<string, object>)record;
                            for (int i = 0; i < reader.FieldCount; i++)
                            {
                                string fieldName = reader.GetName(i);
                                if (columnCollection.ContainsKey(fieldName))
                                {
                                    ReportColumnDTO reportColumn = (ReportColumnDTO)columnCollection[fieldName];
                                    recordMembers.Add(reportColumn.displayName, GetDefaultIfDBNull(reader.GetValue(i), reader.GetFieldType(i)));
                                }
                            }
                            yield return record;
                        }
                    }
                }
                //}
            }
        }



        public dynamic ExecuteAndGetSingleRowUsingKey(string commandKey, params object[] parameters)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                Contract.Requires(!string.IsNullOrWhiteSpace(commandKey));
                Contract.Requires(parameters != null);

                QueryDTO query = MetaQueryManager.Instance[commandKey];
                IDictionary<string, object> tmpParams = Dilizity.Core.Util.Utility.Param2Dictionary(parameters);
                Log.Debug(this.GetType(), "commandKey={0}", commandKey);

                //lock (this)
                //{
                using (var command = connection.CreateCommand())
                {
                    command.CommandText = query.Sql;
                    command.CommandTimeout = Utility.ConvertStringToInt(ConfigReader.Instance.Settings("CommandTimeOut"));

                    //Log.Debug(this.GetType(), "SQL={0}", query.Sql);
                    foreach (var SqlParam in query.ParamCollection)
                    {
                        string name = SqlParam.Key;
                        SqlParamDTO sqlParamDt = SqlParam.Value;
                        var p = command.CreateParameter();
                        p.ParameterName = sqlParamDt.Name;
                        p.DbType = sqlParamDt.DBType;
                        p.Value = tmpParams[sqlParamDt.Name];
                        command.Parameters.Add(p);
                    }

                    Log.Debug(this.GetType(), "Before Calling CommandSQL={0} with connection state = {1}", query.Sql, command.Connection.State);
                    using (var reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            dynamic record = new ExpandoObject();
                            var recordMembers = (IDictionary<string, object>)record;
                            for (int i = 0; i < reader.FieldCount; i++)
                            {
                                recordMembers.Add(reader.GetName(i), GetDefaultIfDBNull(reader.GetValue(i), reader.GetFieldType(i)));
                            }
                            return record;
                        }
                        return null;
                    }
                }
                //}
            }
        }


        public int ExecuteNonQuery(string commandText, params KeyValuePair<string, object>[] parameters)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                Contract.Requires(!string.IsNullOrWhiteSpace(commandText));
                Contract.Requires(parameters != null);

                Log.Debug(this.GetType(), "SQL={0}", commandText);


                //lock (this)
                //{
                    using (var command = connection.CreateCommand())
                    {
                        command.CommandText = commandText;
                        foreach (var parameter in parameters)
                        {
                            var p = command.CreateParameter();
                            p.ParameterName = parameter.Key;
                            p.Value = parameter.Value;
                            command.Parameters.Add(p);
                        }
                        int result = command.ExecuteNonQuery();
                        return result;
                    }
                //}
            }
        }

        public int ExecuteBulkNonQueryUsingKey(string commandKey, List<dynamic> dbObjects)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                Contract.Requires(!string.IsNullOrWhiteSpace(commandKey));
                Contract.Requires(dbObjects != null);

                Log.Debug(this.GetType(), "commandKey={0}", commandKey);


                QueryDTO query = MetaQueryManager.Instance[commandKey];
                StringBuilder sqls = new StringBuilder();
                foreach(dynamic tmpObjects in dbObjects)
                {
                    IDictionary<string, Object> tmpObject = (IDictionary<string, Object>)tmpObjects;
                    string template = query.Sql;
                    foreach (var SqlParam in query.ParamCollection)
                    {
                        string name = SqlParam.Key;
                        SqlParamDTO sqlParamDt = SqlParam.Value;
                        object tObject = tmpObject[name];
                        string sObject = Utility.ObjectToString(tObject, sqlParamDt.DBType);
                        template = template.Replace("@"+name, (string)sObject);
                    }
                    sqls.Append(template);
                }

                //lock (this)
                //{
                using (var command = connection.CreateCommand())
                {
                    if (this.transaction != null)
                        command.Transaction = this.transaction;
                    Log.Debug(this.GetType(), "SQL={0}", sqls.ToString());
                    command.CommandText = sqls.ToString();
                    int result = command.ExecuteNonQuery();
                    return result;
                }
               // }
            }
        }

        public int ExecuteNonQueryUsingKey(string commandKey, params object[] parameters)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                Contract.Requires(!string.IsNullOrWhiteSpace(commandKey));
                Contract.Requires(parameters != null);

                Log.Debug(this.GetType(), "commandKey={0}", commandKey);


                QueryDTO query = MetaQueryManager.Instance[commandKey];
                IDictionary<string, object> tmpParams = Util.Utility.Param2Dictionary(parameters);

                //lock (this)
                //{
                using (var command = connection.CreateCommand())
                {
                    if (this.transaction != null)
                        command.Transaction = this.transaction;
                    command.CommandText = query.Sql;
                    Log.Debug(this.GetType(), "SQL={0}", query.Sql);
                    foreach (var SqlParam in query.ParamCollection)
                    {
                        string name = SqlParam.Key;
                        SqlParamDTO sqlParamDt = SqlParam.Value;
                        var p = command.CreateParameter();
                        p.ParameterName = sqlParamDt.Name;
                        p.DbType = sqlParamDt.DBType;
                        p.Value = tmpParams[sqlParamDt.Name];
                        command.Parameters.Add(p);

                    }

                    int result = command.ExecuteNonQuery();
                    return result;
                }
                // }
            }
        }

        public int DelayExecuteBulk()
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                int result = -1;
                string sql = sqlCollection.ToString();
                //Contract.Requires(!string.IsNullOrWhiteSpace(sql));
                if (!string.IsNullOrWhiteSpace(sql))
                {
                    Log.Debug(this.GetType(), "sql={0}", sql);

                    //lock (this)
                    //{
                    using (var command = connection.CreateCommand())
                    {
                        if (this.transaction != null)
                            command.Transaction = this.transaction;
                        command.CommandText = sql;

                        result = command.ExecuteNonQuery();
                    }
                    // }
                }
                return result;
            }
        }

        public void DelayExecuteNonQueryUsingKey(string commandKey, params object[] parameters)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                Contract.Requires(!string.IsNullOrWhiteSpace(commandKey));
                Contract.Requires(parameters != null);

                Log.Debug(this.GetType(), "commandKey={0}", commandKey);


                QueryDTO query = MetaQueryManager.Instance[commandKey];
                StringBuilder sqls = new StringBuilder();
                IDictionary<string, object> tmpParams = Dilizity.Core.Util.Utility.Param2Dictionary(parameters);
                string template = query.Sql;
                foreach (var SqlParam in query.ParamCollection)
                {
                    string name = SqlParam.Key;
                    SqlParamDTO sqlParamDt = SqlParam.Value;
                    object tObject = tmpParams[name];
                    string sObject = Utility.ObjectToString(tObject, sqlParamDt.DBType);
                    //template = template.Replace("@" + name, (string)sObject);
                    string expression = string.Format(@"@\b{0}\b", name);
                    template = Regex.Replace(template, expression, (string)sObject);
                }
                sqlCollection.Append(template);
            }
        }

        public object ExecuteScalar(string commandText, params KeyValuePair<string, object>[] parameters)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                Contract.Requires(!string.IsNullOrWhiteSpace(commandText));
                Contract.Requires(parameters != null);

                

                //lock (this)
                //{
                    using (var command = connection.CreateCommand())
                    {
                        commandText += "SELECT SCOPE_IDENTITY();";
                        command.CommandText = commandText;
                        Log.Debug(this.GetType(), "SQL={0}", commandText);
                        foreach (var parameter in parameters)
                        {
                            var p = command.CreateParameter();
                            p.ParameterName = parameter.Key;
                            p.Value = parameter.Value;
                            command.Parameters.Add(p);
                        }
                        object result = command.ExecuteScalar();
                        return result;
                    }
               // }
            }
        }

        public object ExecuteScalarUsingKey(string commandKey, params object[] parameters)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                Contract.Requires(!string.IsNullOrWhiteSpace(commandKey));
                Contract.Requires(parameters != null);

                QueryDTO query = MetaQueryManager.Instance[commandKey];
                IDictionary<string, object> tmpParams = Dilizity.Core.Util.Utility.Param2Dictionary(parameters);
                Log.Debug(this.GetType(), "commandKey={0}", commandKey);

                //lock (this)
               // {
                    using (var command = connection.CreateCommand())
                    {
                        if (this.transaction != null)
                            command.Transaction = this.transaction;
                        command.CommandText = query.Sql;
                         
                        Log.Debug(this.GetType(), "SQL={0}", command.CommandText);

                        foreach (var SqlParam in query.ParamCollection)
                        {
                            string name = SqlParam.Key;
                            SqlParamDTO sqlParamDt = SqlParam.Value;
                            var p = command.CreateParameter();
                            p.ParameterName = sqlParamDt.Name;
                            p.DbType = sqlParamDt.DBType;
                            if (tmpParams[sqlParamDt.Name] == null)
                                p.Value = DBNull.Value;
                            else
                                p.Value = tmpParams[sqlParamDt.Name];

                            command.Parameters.Add(p);
                        }

                        object result = command.ExecuteScalar();
                    
                        return Convert.ToInt32(result);
                }
                //}
            }
        }

        public int BeginTransaction()
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                if (this.connection != null)
                    this.transaction = this.connection.BeginTransaction();
                return 0;
            }
        }

        public int CommitTransaction()
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {  
                if (this.transaction != null)
                    this.transaction.Commit();
                return 0;
            }
        }

        public int RollbackTransaction()
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                if (this.transaction != null)
                    this.transaction.Rollback();
                return 0;
            }
        }


        public void Dispose()
        {
            if (this.transaction != null)
            {
                this.transaction.Dispose();
                this.transaction = null;
            }

            if (this.connection != null)
            {
                if (this.connection.State != System.Data.ConnectionState.Closed)
                    this.connection.Close();
                this.connection.Dispose();
                this.connection = null;
            }
                

            this.IsDisposed = true;
        }

        private object GetDefaultIfDBNull(object value, Type type)
        {
            var dbnull = value as DBNull;
            if (dbnull != null)
            {
                switch (Type.GetTypeCode(type))
                {
                    case TypeCode.Boolean: return default(bool);
                    case TypeCode.Byte: return default(byte);
                    case TypeCode.Char: return default(char);
                    case TypeCode.DateTime: return default(DateTime);
                    case TypeCode.Decimal: return default(decimal);
                    case TypeCode.Double: return default(double);
                    case TypeCode.Int16: return default(short);
                    case TypeCode.Int32: return default(int);
                    case TypeCode.Int64: return default(long);
                    case TypeCode.SByte: return default(sbyte);
                    case TypeCode.Single: return default(float);
                    case TypeCode.String: return default(string);
                    case TypeCode.UInt16: return default(ushort);
                    case TypeCode.UInt32: return default(uint);
                    case TypeCode.UInt64: return default(ulong);
                    default: return default(object);
                }
            }
            return value;
        }
    }
}
