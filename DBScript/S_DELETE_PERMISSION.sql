DROP PROCEDURE dbo.SP_DELETE_PERMISSION_HARD
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE dbo.SP_DELETE_PERMISSION_HARD
	-- Add the parameters for the stored procedure here
	@PERMISSION_ID INT
AS
BEGIN

	DELETE FROM SEC_ROLE_PERMISSION
	WHERE  PERMISSION_ID = @PERMISSION_ID;

	DELETE FROM MSG_ASSIGNED_TEMPLATES 
	WHERE  PERMISSION_ID = @PERMISSION_ID;

	DELETE FROM SEC_PERMISSION
	WHERE  PERMISSION_ID = @PERMISSION_ID;

END
GO
