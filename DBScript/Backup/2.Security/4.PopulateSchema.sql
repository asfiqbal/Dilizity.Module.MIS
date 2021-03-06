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


INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity', NULL, 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO


INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity.Login',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity.Login.Email', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Login'), 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT N'Dilizity.Login.SMS', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Login'), 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity.ChangePassword', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity'), 0, 0, 0, 1, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO
INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity.ChangePassword.Email', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.ChangePassword'), 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT N'Dilizity.ChangePassword.SMS', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.ChangePassword'), 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity.Backoffice',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity.Backoffice.Role',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity.Backoffice.Role.Search',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Role')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT N'Dilizity.Backoffice.Role.Add',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Role')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT N'Dilizity.Backoffice.Role.Edit',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Role')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT N'Dilizity.Backoffice.Role.Delete',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Role')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT N'Dilizity.Backoffice.Role.View',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Role')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
--UNION ALL
--SELECT N'Dilizity.Backoffice.Role.Maker',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Role')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
--UNION ALL
--SELECT N'Dilizity.Backoffice.Role.Checker',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Role')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity.Backoffice.Role.Add.Maker',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Role.Add')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT N'Dilizity.Backoffice.Role.Add.Checker',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Role.Add')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT N'Dilizity.Backoffice.Role.Add.Email',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Role.Add')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity.Backoffice.Role.Delete.Email',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Role.Delete')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO



INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity.Backoffice.User',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity.Backoffice.User.Search',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.User')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT N'Dilizity.Backoffice.User.Add',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.User')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT N'Dilizity.Backoffice.User.Edit',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.User')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT N'Dilizity.Backoffice.User.Delete',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.User')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT N'Dilizity.Backoffice.User.View',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.User')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
--UNION ALL
--SELECT N'Dilizity.Backoffice.User.Maker',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.User')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
--UNION ALL
--SELECT N'Dilizity.Backoffice.User.Checker',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.User')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity.Backoffice.User.Add.Email',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.User.Add')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity.Backoffice.DataSource',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity.Backoffice.DataSource.Add',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.DataSource')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT N'Dilizity.Backoffice.DataSource.Edit',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.DataSource')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT N'Dilizity.Backoffice.DataSource.Delete',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.DataSource')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT N'Dilizity.Backoffice.DataSource.View',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.DataSource')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
--UNION ALL
--SELECT N'Dilizity.Backoffice.DataSource.Maker',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.DataSource')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
--UNION ALL
--SELECT N'Dilizity.Backoffice.DataSource.Checker',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.DataSource')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity.Backoffice.DataSource.Add.Email',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.DataSource.Add')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity.Backoffice.Report',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity.Backoffice.Report.Add',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Report')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT N'Dilizity.Backoffice.Report.Edit',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Report')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT N'Dilizity.Backoffice.Report.Delete',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Report')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT N'Dilizity.Backoffice.Report.View',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Report')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
--UNION ALL
--SELECT N'Dilizity.Backoffice.Report.Maker',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Report')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
--UNION ALL
--SELECT N'Dilizity.Backoffice.Report.Checker',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Report')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity.Backoffice.Report.Add.Email',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Report.Add')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO


INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity.Backoffice.Maker',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice'), 1, 1, 1, 1, 1, 1, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity.Backoffice.Maker.Search',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Maker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT N'Dilizity.Backoffice.Maker.Add',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Maker')         , 1, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT N'Dilizity.Backoffice.Maker.Edit',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Maker')         , 0, 1, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT N'Dilizity.Backoffice.Maker.Delete',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Maker')         , 0, 0, 1, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT N'Dilizity.Backoffice.Maker.View',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Maker')         , 0, 0, 0, 1, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity.Backoffice.Checker',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice'), 0, 1, 1, 1, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity.Backoffice.Checker.Search',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT N'Dilizity.Backoffice.Checker.Edit',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Checker')         , 0, 1, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT N'Dilizity.Backoffice.Checker.Delete',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Checker')         , 0, 0, 1, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT N'Dilizity.Backoffice.Checker.View',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Checker')         , 0, 0, 0, 1, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity.FrontOffice',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity.FrontOffice.Report',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.FrontOffice')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity.FrontOffice.Report.Administration',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.FrontOffice.Report')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity.FrontOffice.Report.Administration.Audit',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.FrontOffice.Report.Administration')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT N'Dilizity.FrontOffice.Report.Administration.Audit.Email',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.FrontOffice.Report.Administration.Audit')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT N'Dilizity.FrontOffice.Report.Administration.Audit.SMS',(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.FrontOffice.Report.Administration.Audit')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
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
SELECT (SELECT ROLE_ID FROM SEC_ROLE WHERE ROLE_NAME = 'Admin'),PERMISSION_ID, 'System', 'System'
FROM SEC_PERMISSION
UNION ALL
SELECT (SELECT ROLE_ID FROM SEC_ROLE WHERE ROLE_NAME = 'Secure'),PERMISSION_ID, 'System', 'System'
FROM SEC_PERMISSION
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
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001, 'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity'),
'Dilizity.Business.Common.Managers.EmailBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',3, 1, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity'),
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
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Login'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Login'),
'Dilizity.API.Security.Managers.AuthenticationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Login'),
'Dilizity.Business.Common.Managers.EmailBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',3, 1, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Login'),
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
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.ChangePassword'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.ChangePassword'),
'Dilizity.API.Security.Managers.ChangePasswordBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.ChangePassword'),
'Dilizity.Business.Common.Managers.EmailBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',3, 1, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.ChangePassword'),
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
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.FrontOffice.Report'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.FrontOffice.Report'),
'Dilizity.API.Security.Managers.ReportExecutionBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.FrontOffice.Report'),
'Dilizity.Business.Common.Managers.EmailBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',3, 1, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.FrontOffice.Report'),
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
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Role.Search'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Role.Search'),
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
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Role.Delete'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Role.Delete'),
'Dilizity.API.Security.Managers.DeleteRoleBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Role.Delete'),
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
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Maker.Search'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Maker.Search'),
'Dilizity.API.Security.Managers.MakerSearchBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Maker.Search'),
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
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Checker.Search'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.Backoffice.Checker.Search'),
'Dilizity.API.Security.Managers.CheckerSearchBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go

update	SEC_PERMISSION
set		action_url = 'index.ActionRole({ makerId: {0}, permissionName: ''{1}''})'
where	PERMISSION_NAME = 'Dilizity.Backoffice.Role.Add.Maker'
go

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

