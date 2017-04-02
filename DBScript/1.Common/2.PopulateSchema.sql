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
UNION ALL
SELECT 500, 'EXECUTION_BEHAVIOR', 'Template Options Type', 'System', 'System'
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
UNION ALL
SELECT 500, 4001,'ON_SUCCESS', 'Default On Success Behavior', 'System', 'System'
UNION ALL
SELECT 500, 4002,'ON_FAIL', 'Default On Fail Behavior', 'System', 'System'
UNION ALL
SELECT 500, 4003,'ON_BOTH', 'Default On Both Success and Fail Behavior', 'System', 'System'

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
UNION ALL
SELECT 8, 'MOBILE_FROM_NUMBER', '88888', 'SMS Gatewat From Number', '0.1', 'System', 'System'
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
SELECT 9, 'ENCRYPT_MSG_BODY', 'False', 'Encrypt Message Bosy', '0.1', 'System', 'System'
GO
--delete from SYSTEM_CONFIGURATION

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
SELECT 10, 'PASSWORD_POLICY_LENGTH_RULE', '8', 'Password Policy Length Rule', '0.1', 'System', 'System'
UNION ALL
SELECT 11, 'PASSWORD_POLICY_COMPLEXITY_RULE', '2', 'Password Policy Complexity Rule', '0.1', 'System', 'System'
UNION ALL
SELECT 12, 'PASSWORD_POLICY_EXPIRY_RULE', '30', 'Password Policy Expiry Rule', '0.1', 'System', 'System'
UNION ALL
SELECT 13, 'PASSWORD_POLICY_NUMBER_CANT_REUSE', '5', 'Password Policy Number can''t reuse', '0.1', 'System', 'System'
UNION ALL
SELECT 14, 'PASSWORD_POLICY_DEFAULT_PASSWORD_ATTEMPTS', '5', 'Password Policy Default Password Attempts', '0.1', 'System', 'System'

GO
--delete from SYSTEM_CONFIGURATION
