DROP FUNCTION FN_MSG_GET_USERS
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION FN_MSG_GET_USERS
(
	@CONTEXTID INT
)
RETURNS 
@OUTTABLE TABLE 
(
	LOGIN_ID VARCHAR(200)
)
AS
BEGIN
	
	INSERT INTO @OUTTABLE(LOGIN_ID)
	SELECT LOGIN_ID
	FROM   SEC_USER
	WHERE  IS_DELETED = 0
	
	RETURN 
END
GO