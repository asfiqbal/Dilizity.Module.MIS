INSERT INTO SEC_DEPARTMENT(
DEPARTMENT_NAME,
IS_SYSTEM,
IS_DELETED,
CREATED_BY,
UPDATED_BY)
SELECT 'Operations', 0, 0, 'System', 'System'
UNION ALL
SELECT 'CRM', 0, 0, 'System', 'System'
UNION ALL
SELECT 'EFT', 0, 0, 'System', 'System'
UNION ALL
SELECT 'Sales', 0, 0, 'System', 'System'
UNION ALL
SELECT 'Pre-Sales', 0, 0, 'System', 'System'
UNION ALL
SELECT 'QA', 0, 0, 'System', 'System'
UNION ALL
SELECT 'BSD', 0, 0, 'System', 'System'
UNION ALL
SELECT 'Marketing', 0, 0, 'System', 'System'
UNION ALL
SELECT 'HR', 0, 0, 'System', 'System'
UNION ALL
SELECT 'Administration', 0, 0, 'System', 'System'
UNION ALL
SELECT 'Network', 0, 0, 'System', 'System'
UNION ALL
SELECT 'Finance', 0, 0, 'System', 'System'
GO

INSERT [dbo].[SEC_PASSWORD_POLICY] ([POLICY_NAME], [LENGTH_RULE], [EXPIRY_RULE], [NUMBER_CANT_REUSE], [COMPLEXITY_RULE], [FIRST_LOGIN_CHANGE_PASSWORD], [IS_SYSTEM], [IS_DELETED], [IS_EMAIL_SENT_ON_LOGON],[IS_SMS_SENT_ON_LOGON], [IS_2FA_ENABLED], DEFAULT_PASSWORD_ATTEMPTS, ACCOUNT_LOCK_ON_FAILED_ATTEMPTS, [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) VALUES (N'Admin Policy', 8, 30, 5, 2, 0, 1, 0, 0,0, 0, 5, 1, getdate(), N'System', getdate(), N'System')
GO

INSERT [dbo].[SEC_PASSWORD_POLICY] ([POLICY_NAME], [LENGTH_RULE], [EXPIRY_RULE], [NUMBER_CANT_REUSE], [COMPLEXITY_RULE], [FIRST_LOGIN_CHANGE_PASSWORD], [IS_SYSTEM], [IS_DELETED], [IS_2FA_ENABLED], DEFAULT_PASSWORD_ATTEMPTS, ACCOUNT_LOCK_ON_FAILED_ATTEMPTS, IS_CAPTCHA_ENABLED, [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
VALUES (N'Secure Policy', --[POLICY_NAME]
		8, --[LENGTH_RULE]
		30, --[EXPIRY_RULE]
		10, --[NUMBER_CANT_REUSE]
		2, --[COMPLEXITY_RULE]
		1, --[FIRST_LOGIN_CHANGE_PASSWORD]
		1, --[IS_SYSTEM]
		0, --[IS_DELETED]
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
SELECT 'Dilizity.Login.TwoFA', N'Login.TwoFA', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Login')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Login.TwoFA.Email', N'Login.TwoFA.Email', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Login.TwoFA'), 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Login.Generate2FAToken', N'Login.Generate2FAToken', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Login')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Login.Generate2FAToken.Email', N'Login.Generate2FAToken.Email', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Login.Generate2FAToken'), 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Login.Generate2FAToken.SMS', N'Login.Generate2FAToken.SMS', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Login.Generate2FAToken'), 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
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
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Add.Save', N'Role.Add.Save', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.Role.Add.Maker.Save', N'Role.Add.Maker.Save', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Maker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Add.Maker.ApprovalReady', N'Role.Add.Maker.ApprovalReady', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Maker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.Role.Add.Checker.Approve', N'Role.Add.Checker.Approve', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Add.Checker.Reject', N'Role.Add.Checker.Reject', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Add.Checker.Correction', N'Role.Add.Checker.Correction', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.Role.Edit.Maker', N'Role.Edit.Maker', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Edit.Checker', N'Role.Edit.Checker', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Edit.Email', N'Role.Edit.Email', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Edit.Save', N'Role.Edit.Save', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.Role.Edit.Maker.Save', N'Role.Edit.Maker.Save', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Maker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Edit.Maker.ApprovalReady', N'Role.Add.Edit.ApprovalReady', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Maker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.Role.Edit.Checker.Approve', N'Role.Edit.Checker.Approve', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Edit.Checker.Reject', N'Role.Edit.Checker.Reject', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Edit.Checker.Correction', N'Role.Edit.Checker.Correction', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.Role.Edit.Checker.Compare', N'Role.Edit.Checker.Compare', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
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


--INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
--SELECT 'Dilizity.Backoffice.Role.Delete.Email', N'Role.Delete.Email', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
--GO




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
UNION ALL
SELECT 'Dilizity.Backoffice.Maker.Delete', N'Maker.Delete', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Maker')         , 0, 0, 1, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.Checker', N'Checker', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice'), 0, 1, 1, 1, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.Checker.Search', N'Checker', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
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

exec SP_BUSINESS_CREATE_PERMISSIONS 'User';

INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
SELECT 'Dilizity.Backoffice.User.ResetPassword', N'User.ResetPassword', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.User.ResetPasswordBulk', N'User.ResetPasswordBulk', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.User.UnblockAccount', N'User.UnblockAccount', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.User.UnblockAccountBulk', N'User.UnblockAccountBulk', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.User.BlockAccount', N'User.BlockAccount', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
UNION ALL
SELECT 'Dilizity.Backoffice.User.BlockAccountBulk', N'User.BlockAccountBulk', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
GO


exec SP_BUSINESS_CREATE_PERMISSIONS 'PasswordPolicy';

INSERT [dbo].[SEC_USER] 
([LOGIN_ID], 
[NAME], 
PICTURE,
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
'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',
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
PICTURE,
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
'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',
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
AND	 P.SYSTEM_NAME NOT LIKE '%Maker%'
AND	 P.SYSTEM_NAME NOT LIKE '%Checker%'
UNION ALL
SELECT (SELECT ROLE_ID FROM SEC_ROLE WHERE ROLE_NAME = 'Secure'),P.PERMISSION_ID, 'System', 'System'
FROM SEC_PERMISSION P
	 LEFT OUTER JOIN SEC_ROLE_PERMISSION RP ON P.PERMISSION_ID = RP.PERMISSION_ID
WHERE RP.PERMISSION_ID IS NULL
AND	 P.SYSTEM_NAME NOT LIKE '%Maker%'
AND	 P.SYSTEM_NAME NOT LIKE '%Checker%'
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


UPDATE	SEC_PERMISSION
set	action_url = 'index.ActionRole({ makerId: {0}, permissionName: ''{1}''})'
where	SYSTEM_NAME LIKE '%.Role.%'
AND (SYSTEM_NAME LIKE '%.Checker%' OR SYSTEM_NAME LIKE '%.Maker%')
GO

update	SEC_PERMISSION
set	DISABLE_TOKEN_VALIDATION = 1
where	SYSTEM_NAME  IN ('Dilizity.Login')
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
WHERE   SYSTEM_NAME = 'Dilizity.Backoffice'
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
WHERE   SYSTEM_NAME = 'Dilizity.Backoffice'
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
        'index.User({ permissionId: '''+P.SYSTEM_NAME+''' })',
		PERMISSION_ID,
		1,
		0, 
		'System','System'
FROM	SEC_PERMISSION P
WHERE   SYSTEM_NAME = 'Dilizity.Backoffice.User'
UNION ALL
SELECT	(SELECT MENU_ID FROM SEC_SIDEBAR_MENU WHERE DISPLAY_NAME = 'Administration'),
		'Role',
        'index.Role({ permissionId: '''+P.SYSTEM_NAME+''' })',
		PERMISSION_ID,
		1,
		0, 
		'System','System'
FROM	SEC_PERMISSION P
WHERE   SYSTEM_NAME = 'Dilizity.Backoffice.Role'
UNION ALL
SELECT	(SELECT MENU_ID FROM SEC_SIDEBAR_MENU WHERE DISPLAY_NAME = 'Administration'),
		'Maker',
        'index.Maker({ permissionId: '''+P.SYSTEM_NAME+''' })',
		PERMISSION_ID,
		1,
		0, 
		'System','System'
FROM	SEC_PERMISSION P
WHERE   SYSTEM_NAME = 'Dilizity.Backoffice.Maker'
UNION ALL
SELECT	(SELECT MENU_ID FROM SEC_SIDEBAR_MENU WHERE DISPLAY_NAME = 'Administration'),
		'Checker',
        'index.Checker({ permissionId: '''+P.SYSTEM_NAME+''' })',
		PERMISSION_ID,
		1,
		0, 
		'System','System'
FROM	SEC_PERMISSION P
WHERE   SYSTEM_NAME = 'Dilizity.Backoffice.Checker'
UNION ALL
SELECT	(SELECT MENU_ID FROM SEC_SIDEBAR_MENU WHERE DISPLAY_NAME = 'Administration'),
		'Password Policy',
        'index.PasswordPolicy({ permissionId: '''+P.SYSTEM_NAME+''' })',
		PERMISSION_ID,
		1,
		0, 
		'System','System'
FROM	SEC_PERMISSION P
WHERE   SYSTEM_NAME = 'Dilizity.Backoffice.PasswordPolicy'
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
        'index.DataSource({ permissionId: '''+P.SYSTEM_NAME+''' })',
		PERMISSION_ID,
		1,
		0, 
		'System','System'
FROM	SEC_PERMISSION P
WHERE   SYSTEM_NAME = 'Dilizity.Backoffice.DataSource'

GO

