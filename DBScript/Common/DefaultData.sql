--DELETE FROM SYSTEM_TYPE
--DELETE FROM SYSTEM_TYPE_DATA
INSERT INTO SYSTEM_TYPE
(
TYPE_ID,
TYPE_NAME,
DESCRIPTION,
CREATED_BY,
UPDATED_BY
)
SELECT 1, 'TEMPLATE_TYPE', 'Default Message Template Type', 'System', 'System'
UNION ALL
SELECT 200, 'FILTER_TYPE', 'Report Filter Type', 'System', 'System'
UNION ALL
SELECT 300, 'FILTER_DATA_TYPE', 'Report Filter Data Type', 'System', 'System'
UNION ALL
SELECT 400, 'TEMPLATE_OPTIONS_TYPE', 'Template Options Type', 'System', 'System'
GO

INSERT INTO SYSTEM_TYPE_DATA
(
TYPE_ID,
TYPE_DATA_ID,
TYPE_DATA,
DESCRIPTION,
CREATED_BY,
UPDATED_BY
)
SELECT 1, 1,'TEMPLATE_TYPE_EMAIL', 'Default Email Template Type', 'System', 'System'
UNION ALL
SELECT 1, 2,'TEMPLATE_TYPE_SMS', 'Default SMS Template Type', 'System', 'System'
UNION ALL
SELECT 200, 1000,'select', 'Default Selection Box Control', 'System', 'System'
UNION ALL
SELECT 200, 1001,'input', 'Default Text Box Control', 'System', 'System'
UNION ALL
SELECT 200, 1002,'datepicker', 'Default Date Calender Control', 'System', 'System'
UNION ALL
SELECT 200, 1003,'textarea', 'Default Text Area Control', 'System', 'System'
UNION ALL
SELECT 200, 1004,'checkbox', 'Default check box Control', 'System', 'System'
UNION ALL
SELECT 200, 1005,'multiCheckbox', 'Default Multi checkbox Control', 'System', 'System'
UNION ALL
SELECT 200, 1006,'radio', 'Default radio Control', 'System', 'System'
UNION ALL
SELECT 200, 1007,'file', 'Default file Control', 'System', 'System'
UNION ALL
SELECT 300, 2000,'System.String', 'String Data Type', 'System', 'System'
UNION ALL
SELECT 300, 2001,'System.Int32', 'Integer Data Type', 'System', 'System'
UNION ALL
SELECT 300, 2002,'System.DateTime', 'Datetime Data Type', 'System', 'System'
UNION ALL
SELECT 400, 3001,'text', 'Default Text Type', 'System', 'System'
UNION ALL
SELECT 400, 3002,'email', 'Default email Type', 'System', 'System'
UNION ALL
SELECT 400, 3003,'password', 'Default password Type', 'System', 'System'
UNION ALL
SELECT 400, 3004,'number', 'Default number Type', 'System', 'System'
UNION ALL
SELECT 400, 3005,'hidden', 'Default hidden Type', 'System', 'System'

GO

INSERT INTO SYSTEM_CONFIGURATION
(
SYSTEM_CONFIGURATION_ID,
NAME,
VALUE,
DESCRIPTION,
VERSION,
CREATED_BY,
UPDATED_BY
)
SELECT 1, 'SMTP_SERVER', 'smtp.gmail.com', 'SMTP Outgoing Server Settings', '0.1', 'System', 'System'
UNION ALL
SELECT 2, 'SMTP_SERVER_FROM_ADDRESS', 'sasifiqbal@gmail.com', 'SMTP Outgoing From Address', '0.1', 'System', 'System'
UNION ALL
SELECT 3, 'SMTP_SERVER_USER_ID', 'sasifiqbal@gmail.com', 'User Id for accessing SMTP Server', '0.1', 'System', 'System'
UNION ALL
SELECT 4, 'SMTP_SERVER_PASSWORD', 'FujJSM6yJIFttqstc+ejXg==', 'User''s Password for accessing SMTP Server', '0.1', 'System', 'System'
UNION ALL
SELECT 5, 'SMTP_SERVER_PORT', '587', 'SMTP Server Port', '0.1', 'System', 'System'
UNION ALL
SELECT 6, 'SMTP_SERVER_ENABLE_SSL', 'True', 'SMTP Server SSL', '0.1', 'System', 'System'
UNION ALL
SELECT 7, 'SMS_SERVER_URL', 'http://localhost/SMSGateWay/Send/{MOBILE_NUMBER}/{MESSAGE}', 'SMS Gatewat URL for Sending SMS', '0.1', 'System', 'System'
GO

--delete from SYSTEM_CONFIGURATION
INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Login'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Login'),
'Dilizity.API.Security.Managers.AuthenticationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Login'),
'Dilizity.Business.Common.Managers.EmailBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',3,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Login'),
'Dilizity.Business.Common.Managers.AuditBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',4,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.ChangePassword'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.ChangePassword'),
'Dilizity.API.Security.Managers.ChangePasswordBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.ChangePassword'),
'Dilizity.Business.Common.Managers.EmailBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',3,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.ChangePassword'),
'Dilizity.Business.Common.Managers.AuditBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',4,'System','System'
go
