DROP FUNCTION FN_MSG_GET_DELETED_ROLES
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION FN_MSG_GET_DELETED_ROLES
(
	@OperationId INT
)
RETURNS 
@OUTTABLE TABLE 
(
	ROLE_ID INT
)
AS
BEGIN

	DECLARE @DELETED_ROLES_STRING VARCHAR(1000);

	SELECT	@DELETED_ROLES_STRING = INPUT_PARAMS
	FROM	OF_OPERATIONS
	WHERE   PARENT_OPERATION_ID = @OperationId
	AND		PERMISSION_CLASS = 'Dilizity.API.Security.Managers.DeleteRoleBusinessManager'

	INSERT	INTO @OUTTABLE(ROLE_ID)
	Select	stringValue from parseJSON(@DELETED_ROLES_STRING)
	where	parent_id is not null
	
	RETURN 
END
GO