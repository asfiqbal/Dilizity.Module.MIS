INSERT [dbo].[SEC_PASSWORD_POLICY] ([POLICY_NAME], [LENGTH_RULE], [EXPIRY_RULE], [NUMBER_CANT_REUSE], [COMPLEXITY_RULE], [FIRST_LOGIN_CHANGE_PASSWORD], [IS_SYSTEM], [IS_DELETED], [IS_EMAIL_SENT_ON_LOGON],[IS_SMS_SENT_ON_LOGON], [IS_2FA_ENABLED], DEFAULT_PASSWORD_ATTEMPTS, ACCOUNT_LOCK_ON_FAILED_ATTEMPTS, [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) VALUES (N'Admin Policy', 8, 30, 5, 2, 0, 1, 0, 0,0, 0, 5, 1, getdate(), N'System', getdate(), N'System')
GO

INSERT [dbo].[SEC_PASSWORD_POLICY] ([POLICY_NAME], [LENGTH_RULE], [EXPIRY_RULE], [NUMBER_CANT_REUSE], [COMPLEXITY_RULE], [FIRST_LOGIN_CHANGE_PASSWORD], [IS_SYSTEM], [IS_DELETED], [IS_EMAIL_SENT_ON_LOGON],[IS_SMS_SENT_ON_LOGON], [IS_2FA_ENABLED], DEFAULT_PASSWORD_ATTEMPTS, ACCOUNT_LOCK_ON_FAILED_ATTEMPTS, IS_CAPTCHA_ENABLED, [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
VALUES (N'Secure Policy', --[POLICY_NAME]
		8, --[LENGTH_RULE]
		30, --[EXPIRY_RULE]
		10, --[NUMBER_CANT_REUSE]
		2, --[COMPLEXITY_RULE]
		1, --[FIRST_LOGIN_CHANGE_PASSWORD]
		1, --[IS_SYSTEM]
		0, --[IS_DELETED]
		1, --[IS_EMAIL_SENT_ON_LOGON]
		1, --[IS_SMS_SENT_ON_LOGON]
		1, --[IS_2FA_ENABLED]
		5, --DEFAULT_PASSWORD_ATTEMPTS
		1, --ACCOUNT_LOCK_ON_FAILED_ATTEMPTS
		1, --[IS_CAPTCHA_ENABLED]
		getdate(), N'System', getdate(), N'System')
GO


INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity', N'Dilizity', NULL, 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO


INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Login', N'Login', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Login.Email', N'Login.Email', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Login'), 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Login.SMS', N'Login.SMS', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Login'), 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.ChangePassword', N'ChangePassword', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity'), 0, 0, 0, 1, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO
INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.ChangePassword.Email', N'ChangePassword.Email', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.ChangePassword'), 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.ChangePassword.SMS', N'ChangePassword.SMS', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.ChangePassword'), 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice', N'Backoffice', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.Role', N'Role', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.Role.Search', N'Role.Search', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Add', N'Role.Add', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Edit', N'Role.Edit', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Delete', N'Role.Delete', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.View', N'Role.View', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
--UNION ALL
--SELECT 'Dilizity.Backoffice.Role.Maker',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
--UNION ALL
--SELECT 'Dilizity.Backoffice.Role.Checker',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.Role.Add.Maker', N'Role.Add.Maker', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Add.Checker', N'Role.Add.Checker', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Add.Email', N'Role.Add.Email', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.Role.Add.Maker.Save', N'Role.Add.Maker.Save', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Maker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Add.Maker.ApprovalReady', N'Role.Add.Maker.ApprovalReady', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Maker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.Role.Add.Checker.Approve', N'Role.Add.Checker.Save', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Add.Checker.Reject', N'Role.Add.Checker.ApprovalReady', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Add.Checker.Correction', N'Role.Add.Checker.Correction', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.Role.Edit.Maker', N'Role.Edit.Maker', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Edit.Checker', N'Role.Edit.Checker', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Edit.Email', N'Role.Edit.Email', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.Role.Edit.Maker.Save', N'Role.Edit.Maker.Save', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Maker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Edit.Maker.ApprovalReady', N'Role.Add.Edit.ApprovalReady', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Maker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.Role.Edit.Checker.Approve', N'Role.Edit.Checker.Save', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Edit.Checker.Reject', N'Role.Edit.Checker.ApprovalReady', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Edit.Checker.Correction', N'Role.Edit.Checker.Correction', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.Role.Delete.Maker', N'Role.Delete.Maker', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Delete.Checker', N'Role.Delete.Checker', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Delete.Bulk', N'Role.Delete.Bulk', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO


INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.Role.Delete.Maker.Save', N'Role.Delete.Maker.Save', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete.Maker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Delete.Maker.ApprovalReady', N'Role.Add.Delete.ApprovalReady', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete.Maker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.Role.Delete.Checker.Approve', N'Role.Delete.Checker.Approve', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Delete.Checker.Reject', N'Role.Delete.Checker.Reject', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Delete.Checker.Correction', N'Role.Delete.Checker.Correction', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO


INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.Role.Delete.Email', N'Role.Delete.Email', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO



INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.User', N'User', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.User.Search', N'User.Search', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.User.Add', N'User.Add', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.User.Edit',  N'User.Edit', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.User.Delete',  N'User.Delete', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.User.View',  N'User.View', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
--UNION ALL
--SELECT 'Dilizity.Backoffice.User.Maker', N'User.Maker', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
--UNION ALL
--SELECT 'Dilizity.Backoffice.User.Checker', N'User.Checker', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.User.Add.Email',  N'User.Add.Email', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User.Add')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.DataSource', N'DataSource', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.DataSource.Add', N'DataSource.Add', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.DataSource')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.DataSource.Edit', N'DataSource.Edit', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.DataSource')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.DataSource.Delete', N'DataSource.Delete',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.DataSource')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.DataSource.View', N'DataSource.View',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.DataSource')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
--UNION ALL
--SELECT 'Dilizity.Backoffice.DataSource.Maker',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.DataSource')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
--UNION ALL
--SELECT 'Dilizity.Backoffice.DataSource.Checker',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.DataSource')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.DataSource.Add.Email', N'DataSource.Add.Email', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.DataSource.Add')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.Report', N'Report', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.Report.Add', N'Report.Add', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Report')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Report.Edit', N'Report.Edit', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Report')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Report.Delete', N'Report.Delete', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Report')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Report.View', N'Report.View', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Report')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
--UNION ALL
--SELECT 'Dilizity.Backoffice.Report.Maker',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Report')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
--UNION ALL
--SELECT 'Dilizity.Backoffice.Report.Checker',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Report')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.Report.Add.Email', N'Report.Add.Email', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Report.Add')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO


INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.Maker', N'Maker', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice'), 1, 1, 1, 1, 1, 1, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.Maker.Search', N'Maker.Search', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Maker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
--UNION ALL
--SELECT 'Dilizity.Backoffice.Maker.Add', N'Maker.Add', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Maker')         , 1, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
--UNION ALL
--SELECT 'Dilizity.Backoffice.Maker.Edit', N'Maker.Edit', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Maker')         , 0, 1, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Maker.Delete', N'Maker.Delete', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Maker')         , 0, 0, 1, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
--UNION ALL
--SELECT 'Dilizity.Backoffice.Maker.View', N'Maker.View', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Maker')         , 0, 0, 0, 1, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.Checker', N'Checker', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice'), 0, 1, 1, 1, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.Checker.Search', N'Checker', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
--UNION ALL
--SELECT 'Dilizity.Backoffice.Checker.Edit', N'Checker.Edit', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Checker')         , 0, 1, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
--UNION ALL
--SELECT 'Dilizity.Backoffice.Checker.Delete', N'Checker.Delete', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Checker')         , 0, 0, 1, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
--UNION ALL
--SELECT 'Dilizity.Backoffice.Checker.View', N'Checker.View', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Checker')         , 0, 0, 0, 1, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.FrontOffice', N'FrontOffice', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.FrontOffice.Report', N'Report', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.FrontOffice')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.FrontOffice.Report.Administration', N'Administration', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.FrontOffice.Report')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.FrontOffice.Report.Administration.Audit', N'Administration.Audit', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.FrontOffice.Report.Administration')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.FrontOffice.Report.Administration.Audit.Email', N'Administration.Audit.Email', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.FrontOffice.Report.Administration.Audit')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.FrontOffice.Report.Administration.Audit.SMS', N'Administration.Audit.SMS', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.FrontOffice.Report.Administration.Audit')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO


INSERT [dbo].[SEC_USER] 
([LOGIN_ID], 
[NAME], 
[PASSWORD], 
[PASSWORD_POLICY_ID], 
PASSWORD_ATTEMPTS,
ACCOUNT_LOCKED, 
CHANGE_PASSWORD_ON_LOGON, 
EMAIL, 
MOBILE_NUMBER, 
LAST_PASSWORD_CHANGE_DATETIME, 
[IS_SYSTEM], 
[IS_DELETED], 
[CREATED_ON], 
[CREATED_BY], 
[UPDATED_ON], 
[UPDATED_BY]
) VALUES (N'Admin',  --[LOGIN_ID]
N'Administrator', --[NAME]
N'FujJSM6yJIEghB7oq65OZQ==',  --Password
(SELECT PASSWORD_POLICY_ID FROM SEC_PASSWORD_POLICY WHERE POLICY_NAME = 'Admin Policy'), --[PASSWORD_POLICY_ID]
5, --PASSWORD_ATTEMPTS
0, --ACCOUNT_LOCKED
0, --CHANGE_PASSWORD_ON_LOGON
'sasifiqbal@gmail.com', --EMAIL
'03028245884', --MOBILE_NUMBER
getdate(), --LAST_PASSWORD_CHANGE_DATETIME
1, --[IS_SYSTEM]
0, --[IS_DELETED]
getdate(), 
N'System', 
getdate(), 
N'System')
GO

INSERT [dbo].[SEC_USER] 
([LOGIN_ID], 
[NAME], 
[PASSWORD], 
[PASSWORD_POLICY_ID], 
PASSWORD_ATTEMPTS,
ACCOUNT_LOCKED, 
CHANGE_PASSWORD_ON_LOGON, 
EMAIL, 
MOBILE_NUMBER, 
LAST_PASSWORD_CHANGE_DATETIME, 
[IS_SYSTEM], 
[IS_DELETED], 
[CREATED_ON], 
[CREATED_BY], 
[UPDATED_ON], 
[UPDATED_BY]
) VALUES (N'SecureUser',  --[LOGIN_ID]
N'Secure User', --[NAME]
N'FujJSM6yJIEghB7oq65OZQ==',  --Password
(SELECT PASSWORD_POLICY_ID FROM SEC_PASSWORD_POLICY WHERE POLICY_NAME = 'Secure Policy'), --[PASSWORD_POLICY_ID]
5, --PASSWORD_ATTEMPTS
0, --ACCOUNT_LOCKED
1, --CHANGE_PASSWORD_ON_LOGON
'sasifiqbal@gmail.com', --EMAIL
'03028245884', --MOBILE_NUMBER
getdate(), --LAST_PASSWORD_CHANGE_DATETIME
1, --[IS_SYSTEM]
0, --[IS_DELETED]
getdate(), 
N'System', 
getdate(), 
N'System')
GO

INSERT [dbo].[SEC_ROLE] ([ROLE_NAME], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Admin', 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT N'Secure', 1, 0, getdate(), N'System', getdate(), N'System'
go



INSERT INTO SEC_ROLE_PERMISSION(ROLE_ID,PERMISSION_ID,CREATED_BY,UPDATED_BY)
SELECT (SELECT ROLE_ID FROM SEC_ROLE WHERE ROLE_NAME = 'Admin'), P.PERMISSION_ID, 'System', 'System'
FROM SEC_PERMISSION P
	 LEFT OUTER JOIN SEC_ROLE_PERMISSION RP ON P.PERMISSION_ID = RP.PERMISSION_ID
WHERE RP.PERMISSION_ID IS NULL
UNION ALL
SELECT (SELECT ROLE_ID FROM SEC_ROLE WHERE ROLE_NAME = 'Secure'),P.PERMISSION_ID, 'System', 'System'
FROM SEC_PERMISSION P
	 LEFT OUTER JOIN SEC_ROLE_PERMISSION RP ON P.PERMISSION_ID = RP.PERMISSION_ID
WHERE RP.PERMISSION_ID IS NULL
go


INSERT INTO [dbo].[SEC_USER_ROLE]([USER_ID], [ROLE_ID], [CREATED_ON], [CREATED_BY], [UPDATED_ON],[UPDATED_BY])
     VALUES((SELECT USER_ID FROM SEC_USER WHERE LOGIN_ID = 'Admin')
           ,(SELECT ROLE_ID FROM SEC_ROLE WHERE [ROLE_NAME] = 'Admin')
           ,getdate(), N'System', getdate(), N'System')
GO

INSERT INTO [dbo].[SEC_USER_ROLE]([USER_ID], [ROLE_ID], [CREATED_ON], [CREATED_BY], [UPDATED_ON],[UPDATED_BY])
     VALUES((SELECT USER_ID FROM SEC_USER WHERE LOGIN_ID = 'SecureUser')
           ,(SELECT ROLE_ID FROM SEC_ROLE WHERE [ROLE_NAME] = 'Secure')
           ,getdate(), N'System', getdate(), N'System')
GO

--DELETE FROM WORK_FLOW_ACTION;

 
INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001, 'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity'),
'Dilizity.Business.Common.Managers.EmailBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',3, 1, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity'),
'Dilizity.Business.Common.Managers.SMSBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',2, 1, 4001, 'System','System'

GO

INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Login'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Login'),
'Dilizity.API.Security.Managers.AuthenticationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Login'),
'Dilizity.Business.Common.Managers.EmailBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',3, 1, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Login'),
'Dilizity.Business.Common.Managers.SMSBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',4, 1, 4001,'System','System'
GO

INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.ChangePassword'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.ChangePassword'),
'Dilizity.API.Security.Managers.ChangePasswordBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.ChangePassword'),
'Dilizity.Business.Common.Managers.EmailBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',3, 1, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.ChangePassword'),
'Dilizity.Business.Common.Managers.SMSBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',4, 1, 4001,'System','System'
go

INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.FrontOffice.Report'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.FrontOffice.Report'),
'Dilizity.API.Security.Managers.ReportExecutionBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.FrontOffice.Report'),
'Dilizity.Business.Common.Managers.EmailBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',3, 1, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.FrontOffice.Report'),
'Dilizity.Business.Common.Managers.SMSBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',4,1,4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Search'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Search'),
'Dilizity.API.Security.Managers.RoleSearchBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete'),
'Dilizity.API.Security.Managers.DeleteRoleBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete'),
'Dilizity.Business.Common.Managers.EmailBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',3, 1, 4001,'System','System'
go

INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Maker.Search'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Maker.Search'),
'Dilizity.API.Security.Managers.MakerSearchBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Maker.Search'),
'Dilizity.Business.Common.Managers.EmailBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',3, 1, 4001,'System','System'
go

INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Checker.Search'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Checker.Search'),
'Dilizity.API.Security.Managers.CheckerSearchBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Checker.Approve'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Checker.Approve'),
'Dilizity.API.Security.Managers.RoleAddUpdateBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Checker.Approve'),
'Dilizity.API.Security.Managers.CheckerApproveBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go

INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Checker'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Checker'),
'Dilizity.API.Security.Managers.RoleAddUpdateBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Checker'),
'Dilizity.API.Security.Managers.CheckerApproveBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go

INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add'),
'Dilizity.API.Security.Managers.RoleAddUpdateBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go

INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit'),
'Dilizity.API.Security.Managers.RoleAddUpdateBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Maker'),
'Dilizity.API.Security.Managers.RoleScreenManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Checker'),
'Dilizity.API.Security.Managers.CheckerScreenManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role'),
'Dilizity.API.Security.Managers.RoleScreenManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go

INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Maker'),
'Dilizity.API.Security.Managers.ActionRoleScreenManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Checker'),
'Dilizity.API.Security.Managers.ActionRoleScreenManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Maker.Save'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Maker.Save'),
'Dilizity.API.Security.Managers.MakerSaveAsDraftBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Maker.ApprovalReady'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Maker.ApprovalReady'),
'Dilizity.API.Security.Managers.MakerApprovalReadyBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go



update	SEC_PERMISSION
set		action_url = 'index.ActionRole({ makerId: {0}, permissionName: ''{1}''})'
where	SYSTEM_NAME LIKE '%.Role.%'
AND (SYSTEM_NAME LIKE '%.Checker.%' OR SYSTEM_NAME LIKE '%.Maker.%')
GO

INSERT INTO SEC_SIDEBAR_MENU(
PARENT_ID,
DISPLAY_NAME,
URL,
STYLE_CLASS,
PERMISSION_ID,
IS_SYSTEM,
IS_DELETED,
CREATED_BY,
UPDATED_BY
)
SELECT	null,
		'Administration',
        NULL,
		'fa fa-edit',
		PERMISSION_ID,
		1,
		0, 
		'System','System'
FROM	SEC_PERMISSION P
WHERE   Permission_NAME = 'Dilizity.Backoffice'
UNION ALL
SELECT	null,
		'Report',
        NULL,
		'fa fa-desktop',
		PERMISSION_ID,
		1,
		0, 
		'System','System'
FROM	SEC_PERMISSION P
WHERE   Permission_NAME = 'Dilizity.Backoffice'
GO

INSERT INTO SEC_SIDEBAR_MENU(
PARENT_ID,
DISPLAY_NAME,
URL,
PERMISSION_ID,
IS_SYSTEM,
IS_DELETED,
CREATED_BY,
UPDATED_BY
)
SELECT	(SELECT MENU_ID FROM SEC_SIDEBAR_MENU WHERE DISPLAY_NAME = 'Administration'),
		'User',
        'index.User({ permissionId: '''+P.PERMISSION_NAME+''' })',
		PERMISSION_ID,
		1,
		0, 
		'System','System'
FROM	SEC_PERMISSION P
WHERE   Permission_NAME = 'Dilizity.Backoffice.User'
UNION ALL
SELECT	(SELECT MENU_ID FROM SEC_SIDEBAR_MENU WHERE DISPLAY_NAME = 'Administration'),
		'Role',
        'index.Role({ permissionId: '''+P.PERMISSION_NAME+''' })',
		PERMISSION_ID,
		1,
		0, 
		'System','System'
FROM	SEC_PERMISSION P
WHERE   Permission_NAME = 'Dilizity.Backoffice.Role'
UNION ALL
SELECT	(SELECT MENU_ID FROM SEC_SIDEBAR_MENU WHERE DISPLAY_NAME = 'Administration'),
		'Maker',
        'index.Maker({ permissionId: '''+P.PERMISSION_NAME+''' })',
		PERMISSION_ID,
		1,
		0, 
		'System','System'
FROM	SEC_PERMISSION P
WHERE   Permission_NAME = 'Dilizity.Backoffice.Maker'
UNION ALL
SELECT	(SELECT MENU_ID FROM SEC_SIDEBAR_MENU WHERE DISPLAY_NAME = 'Administration'),
		'Checker',
        'index.Checker({ permissionId: '''+P.PERMISSION_NAME+''' })',
		PERMISSION_ID,
		1,
		0, 
		'System','System'
FROM	SEC_PERMISSION P
WHERE   Permission_NAME = 'Dilizity.Backoffice.Checker'
GO


INSERT INTO SEC_SIDEBAR_MENU(
PARENT_ID,
DISPLAY_NAME,
URL,
PERMISSION_ID,
IS_SYSTEM,
IS_DELETED,
CREATED_BY,
UPDATED_BY
)
SELECT	(SELECT MENU_ID FROM SEC_SIDEBAR_MENU WHERE DISPLAY_NAME = 'Report'),
		'Data Sources',
        'index.DataSource({ permissionId: '''+P.PERMISSION_NAME+''' })',
		PERMISSION_ID,
		1,
		0, 
		'System','System'
FROM	SEC_PERMISSION P
WHERE   Permission_NAME = 'Dilizity.Backoffice.DataSource'

GO

