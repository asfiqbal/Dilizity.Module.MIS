sqlcmd -S WIN-F9P1PSC1JMQ -U sa -P Avanza123 -d master -i D:\Work\Dilizity.Product.MIS\Dilizity.Module.MIS\DBScript\0.Database\1.CreateSchema.sql >> QueryLog.txt


sqlcmd -S WIN-F9P1PSC1JMQ -U sa -P Avanza123 -d ReportMIS -i D:\Work\Dilizity.Product.MIS\Dilizity.Module.MIS\DBScript\1.Common\1.CreateSchema.sql >> QueryLog.txt
sqlcmd -S WIN-F9P1PSC1JMQ -U sa -P Avanza123 -d ReportMIS -i D:\Work\Dilizity.Product.MIS\Dilizity.Module.MIS\DBScript\1.Common\2.PopulateSchema.sql >> QueryLog.txt
sqlcmd -S WIN-F9P1PSC1JMQ -U sa -P Avanza123 -d ReportMIS -i D:\Work\Dilizity.Product.MIS\Dilizity.Module.MIS\DBScript\1.Common\3.dbo.parseJSON.sql >> QueryLog.txt

sqlcmd -S WIN-F9P1PSC1JMQ -U sa -P Avanza123 -d ReportMIS -i D:\Work\Dilizity.Product.MIS\Dilizity.Module.MIS\DBScript\2.Security\1.CreateSchema.sql >> QueryLog.txt
sqlcmd -S WIN-F9P1PSC1JMQ -U sa -P Avanza123 -d ReportMIS -i D:\Work\Dilizity.Product.MIS\Dilizity.Module.MIS\DBScript\2.Security\2.PopulateSchema.sql >> QueryLog.txt
sqlcmd -S WIN-F9P1PSC1JMQ -U sa -P Avanza123 -d ReportMIS -i D:\Work\Dilizity.Product.MIS\Dilizity.Module.MIS\DBScript\2.Security\2.1.PopulateWorkFlow.sql >> QueryLog.txt
sqlcmd -S WIN-F9P1PSC1JMQ -U sa -P Avanza123 -d ReportMIS -i D:\Work\Dilizity.Product.MIS\Dilizity.Module.MIS\DBScript\2.Security\3.FN_GET_FRIENDLY_PERMISSION_NAME.sql >> QueryLog.txt
sqlcmd -S WIN-F9P1PSC1JMQ -U sa -P Avanza123 -d ReportMIS -i D:\Work\Dilizity.Product.MIS\Dilizity.Module.MIS\DBScript\2.Security\4.1VIEWS.sql >> QueryLog.txt


sqlcmd -S WIN-F9P1PSC1JMQ -U sa -P Avanza123 -d ReportMIS -i D:\Work\Dilizity.Product.MIS\Dilizity.Module.MIS\DBScript\3.OperationFramework\1.CreateSchema.sql >> QueryLog.txt
sqlcmd -S WIN-F9P1PSC1JMQ -U sa -P Avanza123 -d ReportMIS -i D:\Work\Dilizity.Product.MIS\Dilizity.Module.MIS\DBScript\3.OperationFramework\2.PopulateSchema.sql >> QueryLog.txt
sqlcmd -S WIN-F9P1PSC1JMQ -U sa -P Avanza123 -d ReportMIS -i D:\Work\Dilizity.Product.MIS\Dilizity.Module.MIS\DBScript\3.OperationFramework\3.VIEWS.sql >> QueryLog.txt

sqlcmd -S WIN-F9P1PSC1JMQ -U sa -P Avanza123 -d ReportMIS -i D:\Work\Dilizity.Product.MIS\Dilizity.Module.MIS\DBScript\4.Messaging\1.CreateSchema.sql >> QueryLog.txt
sqlcmd -S WIN-F9P1PSC1JMQ -U sa -P Avanza123 -d ReportMIS -i D:\Work\Dilizity.Product.MIS\Dilizity.Module.MIS\DBScript\4.Messaging\2.PopulateSchema.sql >> QueryLog.txt
sqlcmd -S WIN-F9P1PSC1JMQ -U sa -P Avanza123 -d ReportMIS -i D:\Work\Dilizity.Product.MIS\Dilizity.Module.MIS\DBScript\4.Messaging\[FN_MSG_GET_DELETED_ROLE_ID].sql >> QueryLog.txt
sqlcmd -S WIN-F9P1PSC1JMQ -U sa -P Avanza123 -d ReportMIS -i D:\Work\Dilizity.Product.MIS\Dilizity.Module.MIS\DBScript\4.Messaging\[FN_MSG_GET_DELETED_ROLE_NAME].sql >> QueryLog.txt
sqlcmd -S WIN-F9P1PSC1JMQ -U sa -P Avanza123 -d ReportMIS -i D:\Work\Dilizity.Product.MIS\Dilizity.Module.MIS\DBScript\4.Messaging\9.FN_MSG_GET_USER_EMAIL.sql >> QueryLog.txt
sqlcmd -S WIN-F9P1PSC1JMQ -U sa -P Avanza123 -d ReportMIS -i D:\Work\Dilizity.Product.MIS\Dilizity.Module.MIS\DBScript\4.Messaging\10.FN_MSG_GET_USER_NAME.sql >> QueryLog.txt
sqlcmd -S WIN-F9P1PSC1JMQ -U sa -P Avanza123 -d ReportMIS -i D:\Work\Dilizity.Product.MIS\Dilizity.Module.MIS\DBScript\4.Messaging\11.FN_MSG_GET_USERS.sql >> QueryLog.txt
sqlcmd -S WIN-F9P1PSC1JMQ -U sa -P Avanza123 -d ReportMIS -i D:\Work\Dilizity.Product.MIS\Dilizity.Module.MIS\DBScript\4.Messaging\12.FN_MSG_GET_USER_LOGIN_DATE.sql >> QueryLog.txt
sqlcmd -S WIN-F9P1PSC1JMQ -U sa -P Avanza123 -d ReportMIS -i D:\Work\Dilizity.Product.MIS\Dilizity.Module.MIS\DBScript\4.Messaging\13.[FN_MSG_GET_OPERATION_DATE_TIME].sql >> QueryLog.txt
sqlcmd -S WIN-F9P1PSC1JMQ -U sa -P Avanza123 -d ReportMIS -i D:\Work\Dilizity.Product.MIS\Dilizity.Module.MIS\DBScript\4.Messaging\13.[FN_MSG_GET_USER_LOGIN_TIME].sql >> QueryLog.txt
sqlcmd -S WIN-F9P1PSC1JMQ -U sa -P Avanza123 -d ReportMIS -i D:\Work\Dilizity.Product.MIS\Dilizity.Module.MIS\DBScript\4.Messaging\14.FN_MSG_GET__DELETED_ROLES.sql >> QueryLog.txt
sqlcmd -S WIN-F9P1PSC1JMQ -U sa -P Avanza123 -d ReportMIS -i D:\Work\Dilizity.Product.MIS\Dilizity.Module.MIS\DBScript\4.Messaging\15.FN_MSG_GET_ROLE_NAME.sql >> QueryLog.txt

sqlcmd -S WIN-F9P1PSC1JMQ -U sa -P Avanza123 -d ReportMIS -i D:\Work\Dilizity.Product.MIS\Dilizity.Module.MIS\DBScript\5.Report\5.CreateSchema.sql >> QueryLog.txt
sqlcmd -S WIN-F9P1PSC1JMQ -U sa -P Avanza123 -d ReportMIS -i D:\Work\Dilizity.Product.MIS\Dilizity.Module.MIS\DBScript\5.Report\6.PopulateSchema.sql >> QueryLog.txt
