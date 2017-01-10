/****** Object:  UserDefinedFunction [dbo].[FN_GET_FRIENDLY_PERMISSION_NAME]    Script Date: 1/7/2017 2:12:31 PM ******/
DROP FUNCTION [dbo].[FN_GET_FRIENDLY_PERMISSION_NAME]
GO

/****** Object:  UserDefinedFunction [dbo].[FN_GET_FRIENDLY_PERMISSION_NAME]    Script Date: 1/7/2017 2:12:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Syed Asif Iqbal
-- Create date: 7-Jan-2017
-- Description:	Returns Permission Name. For example if permission name is Dilizity.BackOffice.Role then
--				Function Returns Role
-- =============================================
CREATE FUNCTION [dbo].[FN_GET_FRIENDLY_PERMISSION_NAME] 
(
	-- Add the parameters for the function here
	@PERMISSION_NAME NVARCHAR(200)
)
RETURNS NVARCHAR(200)
AS
BEGIN
	DECLARE @OUTSTRING NVARCHAR(200)

	SELECT @OUTSTRING = REVERSE(SUBSTRING(REVERSE(@PERMISSION_NAME),0,CHARINDEX('.',REVERSE(@PERMISSION_NAME))))

	IF LEN(@OUTSTRING) <= 0 
		SELECT @OUTSTRING = @PERMISSION_NAME

	RETURN @OUTSTRING

END

GO


