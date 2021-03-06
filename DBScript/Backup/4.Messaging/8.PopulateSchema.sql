--DELETE FROM MSG_ASSIGNED_TEMPLATES;
--DELETE FROM MSG_TEMPLATES;
--DELETE FROM MSG_TEMPLATE_CODES;
GO


INSERT MSG_TEMPLATE_CODES 
(
NAME,
DESCRIPTION,
MULTIPLE_RESULT,
CONTEXT_AWARE,
DATA_FUNCTION,
IS_DELETED,
IS_SYSTEM,
CREATED_BY,
UPDATED_BY
)
SELECT 'USERS','Return List of Users','TRUE','TRUE','SELECT * FROM dbo.FN_MSG_GET_USERS({0})',0,1,'System','System'
UNION ALL
SELECT 'USER_NAME','Return Name of User','FALSE','TRUE','SELECT dbo.FN_MSG_GET_USER_NAME({0})',0,1,'System','System'
UNION ALL
SELECT 'USER_EMAIL_ADDRESS','Return Email address of User','FALSE','TRUE','SELECT dbo.FN_MSG_GET_USER_EMAIL({0})',0,1,'System','System'
UNION ALL
SELECT 'USER_LOGIN_DATE','Return Login Date of User','FALSE','TRUE','SELECT dbo.FN_MSG_GET_USER_LOGIN_DATE({0})',0,1,'System','System'
UNION ALL
SELECT 'USER_LOGIN_TIME','Return Login Time of User','FALSE','TRUE','SELECT dbo.FN_MSG_GET_USER_LOGIN_TIME({0})',0,1,'System','System'
UNION ALL
SELECT 'DELETED_ROLES','Return All Deleted Roles for specific Operation','TRUE','TRUE','SELECT * FROM dbo.FN_MSG_GET_DELETED_ROLES({0})',0,1,'System','System'
UNION ALL
SELECT 'DELETED_ROLE_ID','Return Deleted Role Id','FALSE','TRUE','SELECT dbo.[FN_MSG_GET_DELETED_ROLE_ID]({0})',0,1,'System','System'
UNION ALL
SELECT 'DELETED_ROLE_NAME','Return Deleted Role Id','FALSE','TRUE','SELECT dbo.[FN_MSG_GET_DELETED_ROLE_NAME]({0})',0,1,'System','System'
UNION ALL
SELECT 'OPERATION_DATETIME','Return Operation Date','FALSE','TRUE','SELECT dbo.[FN_MSG_GET_OPERATION_DATETIME]({0})',0,1,'System','System'

GO


INSERT MSG_TEMPLATES 
(
NAME,
DESCRIPTION,
TEMPLATE_TYPE,
TEMPLATE,
SUBJECT,
IS_DELETED,
IS_SYSTEM,
CREATED_BY,
UPDATED_BY
)
SELECT 'SUCCESS_LOGIN_TEMPLATE',
		'Default Success Email Login Template',
		1,
		'Dear <USER_NAME/>, '+CHAR(13) + CHAR(10) +'This is to inform you that you have successfully logged into the MIS Portal on <USER_LOGIN_DATE/> at <USER_LOGIN_TIME/>' + CHAR(13) + CHAR(10) +'For any query please call Support at 111-DILIZITY or send an email to customer.services@dilizity.com.'+CHAR(13) + CHAR(10) +'Thank you,'+CHAR(13) + CHAR(10) +'Dilizity Team',
		'Dilizity Successfully Logged-in',
		0,1,'System','System'
UNION ALL
SELECT	'SUCCESS_SMS_LOGIN_TEMPLATE',
		'Default Success SMS Login Template',
		2,
		'This is to inform you that you have successfully logged into the MIS Portal on <USER_LOGIN_DATE/> at <USER_LOGIN_TIME/>',
		'',
		0,1,'System','System'
UNION ALL
SELECT 'SUCCESS_CHANGE_PASSWORD_TEMPLATE',
		'Default Success Email Change Password Template',
		1,
		'Dear <USER_NAME/>, '+CHAR(13) + CHAR(10) +'This is to inform you that you have successfully changed your password on <OPERATION_DATE_TIME/>.' + CHAR(13) + CHAR(10) +'For any query please call Support at 111-DILIZITY or send an email to customer.services@dilizity.com.'+CHAR(13) + CHAR(10) +'Thank you,'+CHAR(13) + CHAR(10) +'Dilizity Team',
		'Dilizity Password Change Success',
		0,1,'System','System'
UNION ALL
SELECT	'SUCCESS_SMS_CHANGE_PASSWORD_TEMPLATE',
		'Default Success SMS Change Password Template',
		2,
		'This is to inform you that you have successfully changed your password on <OPERATION_DATE_TIME/>.',
		'',
		0,1,'System','System'
UNION ALL
SELECT 'SUCCESS_DELETE_ROLE',
		'Default Success Delete Role',
		1,
		'Dear <USER_NAME/>, '+CHAR(13) + CHAR(10) +'Following Roles have successfully deleted.' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10) +'Role Id, Role Name, Deleted DateTime<DELETED_ROLES><DELETED_ROLE_ID/>, <DELETED_ROLE_NAME/>, <OPERATION_DATETIME/></DELETED_ROLES>.'+CHAR(13) + CHAR(10) +'For any query please call Support at 111-DILIZITY or send an email to customer.services@dilizity.com.'+CHAR(13) + CHAR(10) +'Thank you,'+CHAR(13) + CHAR(10) +'Dilizity Team',
		'Dilizity: Roles Deleted Successfully', 
		0,1,'System','System'
GO




INSERT MSG_ASSIGNED_TEMPLATES 
(
PERMISSION_ID,
TEMPLATE_ID,
IS_SYSTEM,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME='Dilizity.Login.Email'), (SELECT TEMPLATE_ID FROM MSG_TEMPLATES WHERE NAME='SUCCESS_LOGIN_TEMPLATE'), 1,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME='Dilizity.Login.SMS'), (SELECT TEMPLATE_ID FROM MSG_TEMPLATES WHERE NAME='SUCCESS_SMS_LOGIN_TEMPLATE'), 1,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME='Dilizity.ChangePassword.Email'), (SELECT TEMPLATE_ID FROM MSG_TEMPLATES WHERE NAME='SUCCESS_CHANGE_PASSWORD_TEMPLATE'), 1,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME='Dilizity.ChangePassword.SMS'), (SELECT TEMPLATE_ID FROM MSG_TEMPLATES WHERE NAME='SUCCESS_SMS_CHANGE_PASSWORD_TEMPLATE'), 1,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME='Dilizity.Backoffice.Role.Delete.Email'), (SELECT TEMPLATE_ID FROM MSG_TEMPLATES WHERE NAME='SUCCESS_DELETE_ROLE'), 1,'System','System'

GO

