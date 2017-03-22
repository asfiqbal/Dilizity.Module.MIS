/****** Object:  StoredProcedure [dbo].[SP_BUSINESS_CREATE_PERMISSIONS]    Script Date: 2/26/2017 11:55:59 PM ******/
DROP PROCEDURE [dbo].[SP_BUSINESS_CREATE_PERMISSIONS]
GO

/****** Object:  StoredProcedure [dbo].[SP_BUSINESS_CREATE_PERMISSIONS]    Script Date: 2/26/2017 11:55:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
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
	UNION ALL
	SELECT @RootPermission+N'.DeleteBulk', @PermissionFriendlyName+N'.DeleteBulk', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission)         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+'.AddMaker', @PermissionFriendlyName+N'.AddMaker', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission)         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+'.AddChecker', @PermissionFriendlyName+N'.AddChecker', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission)         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+'.EditMaker', @PermissionFriendlyName+N'.EditMaker', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission)         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+'.EditChecker', @PermissionFriendlyName+N'.EditChecker', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission)         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+N'.DeleteMaker', @PermissionFriendlyName+N'.DeleteMaker', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission)         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+N'.DeleteChecker', @PermissionFriendlyName+N'.DeleteChecker', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission)         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'


	INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
	SELECT @RootPermission+'.Add.Save', @PermissionFriendlyName+N'.Add.Save', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+'.Add')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System';


	INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
	SELECT @RootPermission+'.AddMaker.Save', @PermissionFriendlyName+N'.AddMaker.Save', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.AddMaker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+'.AddMaker.ApprovalReady', @PermissionFriendlyName+N'.AddMaker.ApprovalReady', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.AddMaker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System';


	INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
	SELECT @RootPermission+'.AddChecker.Approve', @PermissionFriendlyName+N'.AddChecker.Approve', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+'.AddChecker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+'.AddChecker.Reject', @PermissionFriendlyName+N'.AddChecker.Reject', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+'.AddChecker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+'.AddChecker.Correction', @PermissionFriendlyName+N'.AddChecker.Correction', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+'.AddChecker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System';


	INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
	SELECT @RootPermission+'.Edit.Save', @PermissionFriendlyName+N'.Edit.Save', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+'.Edit')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System';

	INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
	SELECT @RootPermission+N'.EditMaker.Save', @PermissionFriendlyName+N'.EditMaker.Save', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.EditMaker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+N'.EditMaker.ApprovalReady', @PermissionFriendlyName+N'.EditMaker.ApprovalReady', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.EditMaker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'

	INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
	SELECT @RootPermission+N'.EditChecker.Approve', @PermissionFriendlyName+N'.EditChecker.Approve', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.EditChecker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+N'.EditChecker.Reject', @PermissionFriendlyName+N'.EditChecker.Reject', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.EditChecker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+N'.EditChecker.Correction', @PermissionFriendlyName+N'.EditChecker.Correction', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.EditChecker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+N'.EditChecker.Compare', @PermissionFriendlyName+N'.EditChecker.Compare', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.EditChecker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'



	INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
	SELECT @RootPermission+N'.DeleteMaker.Save', @PermissionFriendlyName+N'.DeleteMaker.Save', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.DeleteMaker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+N'.DeleteMaker.ApprovalReady', @PermissionFriendlyName+N'.DeleteMaker.ApprovalReady', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.DeleteMaker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'

	INSERT [dbo].[SEC_PERMISSION] ([SYSTEM_NAME], [PERMISSION_NAME], [PARENT_PERMISSION_ID], [CAN_ADD], [CAN_UPDATE], [CAN_DELETE], [CAN_VIEW], [CAN_MAKE], [CAN_CHECK],  [CAN_EXECUTE], [IS_SYSTEM], [IS_DELETED], [CREATED_ON], [CREATED_BY], [UPDATED_ON], [UPDATED_BY]) 
	SELECT @RootPermission+N'.DeleteChecker.Approve', @PermissionFriendlyName+N'.DeleteChecker.Approve', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.DeleteChecker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+N'.DeleteChecker.Reject', @PermissionFriendlyName+N'.DeleteChecker.Reject', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.DeleteChecker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'
	UNION ALL
	SELECT @RootPermission+N'.DeleteChecker.Correction', @PermissionFriendlyName+N'.DeleteChecker.Correction', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = @RootPermission+N'.DeleteChecker')         , 0, 0, 0, 0, 0, 0, 0, 1, 0, getdate(), N'System', getdate(), N'System'


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
	;
    
	
END

GO


