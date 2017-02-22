/****** Object:  StoredProcedure [dbo].[SP_BUSINESS_CREATE_PERMISSIONS]    Script Date: 2/22/2017 8:21:21 PM ******/
DROP PROCEDURE [dbo].[SP_BUSINESS_CREATE_PERMISSIONS]
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_BUSINESS_CREATE_PERMISSIONS]
	@P_BUSINESS NVARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @RootPermission VARCHAR(500), @Permission VARCHAR(500), @PermissionFriendlyName VARCHAR(500)

	SELECT @RootPermission = 'Dilizity.Backoffice.' + @P_BUSINESS;
	SELECT @Permission = @RootPermission;
	SELECT @PermissionFriendlyName = @P_BUSINESS;

	INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
	SELECT @Permission, @P_BUSINESS, (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System';
	

	INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
	SELECT @RootPermission +'.Search', @P_BUSINESS+N'.Search', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission)         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+'.Add', @P_BUSINESS+N'.Add', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission)         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+'.Edit', @P_BUSINESS+N'.Edit', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission)         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+'.Delete', @P_BUSINESS+N'.Delete', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission)         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+'.View', @P_BUSINESS+N'.View', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission)         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'


	INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
	SELECT @RootPermission+'.Add.Maker', @PermissionFriendlyName+N'.Add.Maker', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+'.Add')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+'.Add.Checker', @PermissionFriendlyName+N'.Add.Checker', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+'.Add')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+'.Add.Save', @PermissionFriendlyName+N'.Add.Save', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+'.Add')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System';


	INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
	SELECT @RootPermission+'.Add.Maker.Save', @PermissionFriendlyName+N'.Add.Maker.Save', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.Add.Maker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+'.Add.Maker.ApprovalReady', @PermissionFriendlyName+N'.Add.Maker.ApprovalReady', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.Add.Maker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System';


	INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
	SELECT @RootPermission+'.Add.Checker.Approve', @PermissionFriendlyName+N'.Add.Checker.Approve', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+'.Add.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+'.Add.Checker.Reject', @PermissionFriendlyName+N'.Add.Checker.Reject', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+'.Add.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+'.Add.Checker.Correction', @PermissionFriendlyName+N'.Add.Checker.Correction', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+'.Add.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System';


	INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
	SELECT @RootPermission+'.Edit.Maker', @PermissionFriendlyName+N'.Edit.Maker', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.Edit')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+'.Edit.Checker', @PermissionFriendlyName+N'.Edit.Checker', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+'.Edit')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+'.Edit.Save', @PermissionFriendlyName+N'.Edit.Save', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+'.Edit')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System';

	INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
	SELECT @RootPermission+N'.Edit.Maker.Save', @PermissionFriendlyName+N'.Edit.Maker.Save', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.Edit.Maker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+N'.Edit.Maker.ApprovalReady', @PermissionFriendlyName+N'.Add.Edit.ApprovalReady', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.Edit.Maker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'

	INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
	SELECT @RootPermission+N'.Edit.Checker.Approve', @PermissionFriendlyName+N'.Edit.Checker.Approve', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.Edit.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+N'.Edit.Checker.Reject', @PermissionFriendlyName+N'.Edit.Checker.Reject', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.Edit.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+N'.Edit.Checker.Correction', @PermissionFriendlyName+N'.Edit.Checker.Correction', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.Edit.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+N'.Edit.Checker.Compare', @PermissionFriendlyName+N'.Edit.Checker.Compare', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.Edit.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'

	INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
	SELECT @RootPermission+N'.Delete.Maker', @PermissionFriendlyName+N'.Delete.Maker', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.Delete')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+N'.Delete.Checker', @PermissionFriendlyName+N'.Delete.Checker', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.Delete')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+N'.Delete.Bulk', @PermissionFriendlyName+N'.Delete.Bulk', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.Delete')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'


	INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
	SELECT @RootPermission+N'.Delete.Maker.Save', @PermissionFriendlyName+N'.Delete.Maker.Save', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.Delete.Maker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+N'.Delete.Maker.ApprovalReady', @PermissionFriendlyName+N'.Add.Delete.ApprovalReady', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.Delete.Maker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'

	INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
	SELECT @RootPermission+N'.Delete.Checker.Approve', @PermissionFriendlyName+N'.Delete.Checker.Approve', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.Delete.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+N'.Delete.Checker.Reject', @PermissionFriendlyName+N'.Delete.Checker.Reject', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.Delete.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+N'.Delete.Checker.Correction', @PermissionFriendlyName+N'.Delete.Checker.Correction', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.Delete.Checker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
    
	
END

GO


