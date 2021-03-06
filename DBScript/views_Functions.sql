/****** Object:  View [VW_WORK_FLOW]    Script Date: 2/14/2017 9:28:54 PM ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[VW_WORK_FLOW]'))
DROP VIEW [VW_WORK_FLOW]
GO
/****** Object:  View [VW_PERMISSION_HIERARCHY]    Script Date: 2/14/2017 9:28:54 PM ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[VW_PERMISSION_HIERARCHY]'))
DROP VIEW [VW_PERMISSION_HIERARCHY]
GO
/****** Object:  View [SEC_VW_DISTINCT_USER_PERMISSION]    Script Date: 2/14/2017 9:28:54 PM ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[SEC_VW_DISTINCT_USER_PERMISSION]'))
DROP VIEW [SEC_VW_DISTINCT_USER_PERMISSION]
GO
/****** Object:  UserDefinedFunction [parseJSON]    Script Date: 2/14/2017 9:28:54 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[parseJSON]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [parseJSON]
GO
/****** Object:  UserDefinedFunction [FN_MSG_GET_USERS]    Script Date: 2/14/2017 9:28:54 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_MSG_GET_USERS]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [FN_MSG_GET_USERS]
GO
/****** Object:  UserDefinedFunction [FN_MSG_GET_USER_NAME]    Script Date: 2/14/2017 9:28:54 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_MSG_GET_USER_NAME]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [FN_MSG_GET_USER_NAME]
GO
/****** Object:  UserDefinedFunction [FN_MSG_GET_USER_LOGIN_TIME]    Script Date: 2/14/2017 9:28:54 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_MSG_GET_USER_LOGIN_TIME]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [FN_MSG_GET_USER_LOGIN_TIME]
GO
/****** Object:  UserDefinedFunction [FN_MSG_GET_USER_LOGIN_DATE]    Script Date: 2/14/2017 9:28:54 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_MSG_GET_USER_LOGIN_DATE]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [FN_MSG_GET_USER_LOGIN_DATE]
GO
/****** Object:  UserDefinedFunction [FN_MSG_GET_USER_EMAIL]    Script Date: 2/14/2017 9:28:54 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_MSG_GET_USER_EMAIL]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [FN_MSG_GET_USER_EMAIL]
GO
/****** Object:  UserDefinedFunction [FN_MSG_GET_ROLE_NAME]    Script Date: 2/14/2017 9:28:54 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_MSG_GET_ROLE_NAME]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [FN_MSG_GET_ROLE_NAME]
GO
/****** Object:  UserDefinedFunction [FN_MSG_GET_OPERATION_DATETIME]    Script Date: 2/14/2017 9:28:54 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_MSG_GET_OPERATION_DATETIME]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [FN_MSG_GET_OPERATION_DATETIME]
GO
/****** Object:  UserDefinedFunction [FN_MSG_GET_DELETED_ROLES]    Script Date: 2/14/2017 9:28:54 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_MSG_GET_DELETED_ROLES]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [FN_MSG_GET_DELETED_ROLES]
GO
/****** Object:  UserDefinedFunction [FN_MSG_GET_DELETED_ROLE_NAME]    Script Date: 2/14/2017 9:28:54 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_MSG_GET_DELETED_ROLE_NAME]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [FN_MSG_GET_DELETED_ROLE_NAME]
GO
/****** Object:  UserDefinedFunction [FN_MSG_GET_DELETED_ROLE_ID]    Script Date: 2/14/2017 9:28:54 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_MSG_GET_DELETED_ROLE_ID]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [FN_MSG_GET_DELETED_ROLE_ID]
GO
/****** Object:  UserDefinedFunction [FN_GET_FRIENDLY_PERMISSION_NAME]    Script Date: 2/14/2017 9:28:54 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_GET_FRIENDLY_PERMISSION_NAME]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [FN_GET_FRIENDLY_PERMISSION_NAME]
GO
/****** Object:  UserDefinedFunction [FN_GET_FRIENDLY_PERMISSION_NAME]    Script Date: 2/14/2017 9:28:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_GET_FRIENDLY_PERMISSION_NAME]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Syed Asif Iqbal
-- Create date: 7-Jan-2017
-- Description:	Returns Permission Name. For example if permission name is Dilizity.BackOffice.Role then
--				Function Returns Role
-- =============================================
CREATE FUNCTION [FN_GET_FRIENDLY_PERMISSION_NAME] 
(
	-- Add the parameters for the function here
	@PERMISSION_NAME NVARCHAR(200)
)
RETURNS NVARCHAR(200)
AS
BEGIN
	DECLARE @OUTSTRING NVARCHAR(200)

	SELECT @OUTSTRING = REVERSE(SUBSTRING(REVERSE(@PERMISSION_NAME),0,CHARINDEX(''.'',REVERSE(@PERMISSION_NAME))))

	IF LEN(@OUTSTRING) <= 0 
		SELECT @OUTSTRING = @PERMISSION_NAME

	RETURN @OUTSTRING

END

' 
END

GO
/****** Object:  UserDefinedFunction [FN_MSG_GET_DELETED_ROLE_ID]    Script Date: 2/14/2017 9:28:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_MSG_GET_DELETED_ROLE_ID]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'

CREATE FUNCTION [FN_MSG_GET_DELETED_ROLE_ID]
(
	@ContextId as varchar(10)
)
RETURNS nvarchar(400)
AS
BEGIN

	RETURN @ContextId
END



' 
END

GO
/****** Object:  UserDefinedFunction [FN_MSG_GET_DELETED_ROLE_NAME]    Script Date: 2/14/2017 9:28:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_MSG_GET_DELETED_ROLE_NAME]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'

CREATE FUNCTION [FN_MSG_GET_DELETED_ROLE_NAME]
(
	@ContextId as varchar(10)
)
RETURNS nvarchar(400)
AS
BEGIN
	DECLARE @Result as nvarchar(400)
	
	select @Result = ROLE_NAME 
	from	SEC_ROLE
	WHERE  ROLE_ID = @ContextId
	RETURN @Result
END



' 
END

GO
/****** Object:  UserDefinedFunction [FN_MSG_GET_DELETED_ROLES]    Script Date: 2/14/2017 9:28:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_MSG_GET_DELETED_ROLES]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [FN_MSG_GET_DELETED_ROLES]
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
	AND		PERMISSION_CLASS = ''Dilizity.API.Security.Managers.DeleteRoleBusinessManager''

	INSERT	INTO @OUTTABLE(ROLE_ID)
	Select	stringValue from parseJSON(@DELETED_ROLES_STRING)
	where	parent_id is not null
	
	RETURN 
END
' 
END

GO
/****** Object:  UserDefinedFunction [FN_MSG_GET_OPERATION_DATETIME]    Script Date: 2/14/2017 9:28:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_MSG_GET_OPERATION_DATETIME]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'

CREATE FUNCTION [FN_MSG_GET_OPERATION_DATETIME]
(
	@OperationId as INT
)
RETURNS nvarchar(200)
AS
BEGIN
	DECLARE @Result as nvarchar(200)
	
	select @Result = cast(DATEPART(HOUR, UPDATED_ON)-12 as varchar)+ '':'' + cast(DATEPART(MINUTE, UPDATED_ON) as varchar)+'':''+cast(DATEPART(SECOND, UPDATED_ON) as varchar)+
    (CASE WHEN DATEPART(HOUR, UPDATED_ON) > 12 THEN '' PM''
        ELSE '' AM''
    END)
	from	OF_OPERATIONS O
	WHERE	O.OPERATION_ID = @OperationId
	RETURN @Result
END
' 
END

GO
/****** Object:  UserDefinedFunction [FN_MSG_GET_ROLE_NAME]    Script Date: 2/14/2017 9:28:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_MSG_GET_ROLE_NAME]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'

CREATE FUNCTION [FN_MSG_GET_ROLE_NAME]
(
	@RoleId as int
)
RETURNS nvarchar(400)
AS
BEGIN
	DECLARE @Result as nvarchar(400)
	
	select @Result = ROLE_NAME 
	from	SEC_ROLE
	WHERE  ROLE_ID = @RoleId
	RETURN @Result
END



' 
END

GO
/****** Object:  UserDefinedFunction [FN_MSG_GET_USER_EMAIL]    Script Date: 2/14/2017 9:28:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_MSG_GET_USER_EMAIL]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'

CREATE FUNCTION [FN_MSG_GET_USER_EMAIL]
(
	@OperationId as INT
)
RETURNS nvarchar(400)
AS
BEGIN
	DECLARE @Result as nvarchar(400)
	
	select @Result = EMAIL 
	from	OF_OPERATIONS O
			INNER JOIN SEC_USER U ON O.CREATED_BY = U.LOGIN_ID
	WHERE	O.OPERATION_ID = @OperationId
	RETURN @Result
END



' 
END

GO
/****** Object:  UserDefinedFunction [FN_MSG_GET_USER_LOGIN_DATE]    Script Date: 2/14/2017 9:28:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_MSG_GET_USER_LOGIN_DATE]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'

CREATE FUNCTION [FN_MSG_GET_USER_LOGIN_DATE]
(
	@OperationId as INT
)
RETURNS nvarchar(200)
AS
BEGIN
	DECLARE @Result as nvarchar(200)
	
	select @Result = cast(DATENAME(dw, LAST_LOGIN_DATETIME) as varchar(3)) + '', '' +  CONVERT(VARCHAR(11),LAST_LOGIN_DATETIME,106)
	from	OF_OPERATIONS O
			INNER JOIN SEC_USER U ON O.CREATED_BY = U.LOGIN_ID
	WHERE	O.OPERATION_ID = @OperationId
	RETURN @Result
END






' 
END

GO
/****** Object:  UserDefinedFunction [FN_MSG_GET_USER_LOGIN_TIME]    Script Date: 2/14/2017 9:28:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_MSG_GET_USER_LOGIN_TIME]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'

CREATE FUNCTION [FN_MSG_GET_USER_LOGIN_TIME]
(
	@OperationId as INT
)
RETURNS nvarchar(200)
AS
BEGIN
	DECLARE @Result as nvarchar(200)
	
	select @Result = cast(DATEPART(HOUR, LAST_LOGIN_DATETIME)-12 as varchar)+ '':'' + cast(DATEPART(MINUTE, LAST_LOGIN_DATETIME) as varchar)+'':''+cast(DATEPART(SECOND, LAST_LOGIN_DATETIME) as varchar)+
    (CASE WHEN DATEPART(HOUR, GETDATE()) > 12 THEN '' PM''
        ELSE '' AM''
    END)
	from	OF_OPERATIONS O
			INNER JOIN SEC_USER U ON O.CREATED_BY = U.LOGIN_ID
	WHERE	O.OPERATION_ID = @OperationId
	RETURN @Result
END
' 
END

GO
/****** Object:  UserDefinedFunction [FN_MSG_GET_USER_NAME]    Script Date: 2/14/2017 9:28:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_MSG_GET_USER_NAME]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'

CREATE FUNCTION [FN_MSG_GET_USER_NAME]
(
	@OperationId as INT
)
RETURNS nvarchar(200)
AS
BEGIN
	DECLARE @Result as nvarchar(200)
	
	select	@Result = NAME 
	from	OF_OPERATIONS O
			INNER JOIN SEC_USER U ON O.CREATED_BY = U.LOGIN_ID
	WHERE	O.OPERATION_ID = @OperationId
	RETURN @Result
END



' 
END

GO
/****** Object:  UserDefinedFunction [FN_MSG_GET_USERS]    Script Date: 2/14/2017 9:28:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_MSG_GET_USERS]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [FN_MSG_GET_USERS]
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
' 
END

GO
/****** Object:  UserDefinedFunction [parseJSON]    Script Date: 2/14/2017 9:28:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[parseJSON]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [parseJSON]( @JSON NVARCHAR(MAX))
	RETURNS @hierarchy TABLE
	  (
	   element_id INT IDENTITY(1, 1) NOT NULL, /* internal surrogate primary key gives the order of parsing and the list order */
	   sequenceNo [int] NULL, /* the place in the sequence for the element */
	   parent_ID INT,/* if the element has a parent then it is in this column. The document is the ultimate parent, so you can get the structure from recursing from the document */
	   Object_ID INT,/* each list or object has an object id. This ties all elements to a parent. Lists are treated as objects here */
	   NAME NVARCHAR(2000),/* the name of the object */
	   StringValue NVARCHAR(MAX) NOT NULL,/*the string representation of the value of the element. */
	   ValueType VARCHAR(10) NOT null /* the declared type of the value represented as a string in StringValue*/
	  )
	AS
	BEGIN
	  DECLARE
	    @FirstObject INT, --the index of the first open bracket found in the JSON string
	    @OpenDelimiter INT,--the index of the next open bracket found in the JSON string
	    @NextOpenDelimiter INT,--the index of subsequent open bracket found in the JSON string
	    @NextCloseDelimiter INT,--the index of subsequent close bracket found in the JSON string
	    @Type NVARCHAR(10),--whether it denotes an object or an array
	    @NextCloseDelimiterChar CHAR(1),--either a ''}'' or a '']''
	    @Contents NVARCHAR(MAX), --the unparsed contents of the bracketed expression
	    @Start INT, --index of the start of the token that you are parsing
	    @end INT,--index of the end of the token that you are parsing
	    @param INT,--the parameter at the end of the next Object/Array token
	    @EndOfName INT,--the index of the start of the parameter at end of Object/Array token
	    @token NVARCHAR(200),--either a string or object
	    @value NVARCHAR(MAX), -- the value as a string
	    @SequenceNo int, -- the sequence number within a list
	    @name NVARCHAR(200), --the name as a string
	    @parent_ID INT,--the next parent ID to allocate
	    @lenJSON INT,--the current length of the JSON String
	    @characters NCHAR(36),--used to convert hex to decimal
	    @result BIGINT,--the value of the hex symbol being parsed
	    @index SMALLINT,--used for parsing the hex value
	    @Escape INT --the index of the next escape character
	    
	  DECLARE @Strings TABLE /* in this temporary table we keep all strings, even the names of the elements, since they are ''escaped'' in a different way, and may contain, unescaped, brackets denoting objects or lists. These are replaced in the JSON string by tokens representing the string */
	    (
	     String_ID INT IDENTITY(1, 1),
	     StringValue NVARCHAR(MAX)
	    )
	  SELECT--initialise the characters to convert hex to ascii
	    @characters=''0123456789abcdefghijklmnopqrstuvwxyz'',
	    @SequenceNo=0, --set the sequence no. to something sensible.
	  /* firstly we process all strings. This is done because [{} and ] aren''t escaped in strings, which complicates an iterative parse. */
	    @parent_ID=0;
	  WHILE 1=1 --forever until there is nothing more to do
	    BEGIN
	      SELECT
	        @start=PATINDEX(''%[^a-zA-Z]["]%'', @json collate SQL_Latin1_General_CP850_Bin);--next delimited string
	      IF @start=0 BREAK --no more so drop through the WHILE loop
	      IF SUBSTRING(@json, @start+1, 1)=''"'' 
	        BEGIN --Delimited Name
	          SET @start=@Start+1;
	          SET @end=PATINDEX(''%[^\]["]%'', RIGHT(@json, LEN(@json+''|'')-@start) collate SQL_Latin1_General_CP850_Bin);
	        END
	      IF @end=0 --no end delimiter to last string
	        BREAK --no more
	      SELECT @token=SUBSTRING(@json, @start+1, @end-1)
	      --now put in the escaped control characters
	      SELECT @token=REPLACE(@token, FROMString, TOString)
	      FROM
	        (SELECT
	          ''\"'' AS FromString, ''"'' AS ToString
	         UNION ALL SELECT ''\\'', ''\''
	         UNION ALL SELECT ''\/'', ''/''
	         UNION ALL SELECT ''\b'', CHAR(08)
	         UNION ALL SELECT ''\f'', CHAR(12)
	         UNION ALL SELECT ''\n'', CHAR(10)
	         UNION ALL SELECT ''\r'', CHAR(13)
	         UNION ALL SELECT ''\t'', CHAR(09)
	        ) substitutions
	      SELECT @result=0, @escape=1
	  --Begin to take out any hex escape codes
	      WHILE @escape>0
	        BEGIN
	          SELECT @index=0,
	          --find the next hex escape sequence
	          @escape=PATINDEX(''%\x[0-9a-f][0-9a-f][0-9a-f][0-9a-f]%'', @token collate SQL_Latin1_General_CP850_Bin)
	          IF @escape>0 --if there is one
	            BEGIN
	              WHILE @index<4 --there are always four digits to a \x sequence   
	                BEGIN
	                  SELECT --determine its value
	                    @result=@result+POWER(16, @index)
	                    *(CHARINDEX(SUBSTRING(@token, @escape+2+3-@index, 1),
	                                @characters)-1), @index=@index+1 ;
	         
	                END
	                -- and replace the hex sequence by its unicode value
	              SELECT @token=STUFF(@token, @escape, 6, NCHAR(@result))
	            END
	        END
	      --now store the string away 
	      INSERT INTO @Strings (StringValue) SELECT @token
	      -- and replace the string with a token
	      SELECT @JSON=STUFF(@json, @start, @end+1,
	                    ''@string''+CONVERT(NVARCHAR(5), @@identity))
	    END
	  -- all strings are now removed. Now we find the first leaf.  
	  WHILE 1=1  --forever until there is nothing more to do
	  BEGIN
	 
	  SELECT @parent_ID=@parent_ID+1
	  --find the first object or list by looking for the open bracket
	  SELECT @FirstObject=PATINDEX(''%[{[[]%'', @json collate SQL_Latin1_General_CP850_Bin)--object or array
	  IF @FirstObject = 0 BREAK
	  IF (SUBSTRING(@json, @FirstObject, 1)=''{'') 
	    SELECT @NextCloseDelimiterChar=''}'', @type=''object''
	  ELSE 
	    SELECT @NextCloseDelimiterChar='']'', @type=''array''
	  SELECT @OpenDelimiter=@firstObject
	  WHILE 1=1 --find the innermost object or list...
	    BEGIN
	      SELECT
	        @lenJSON=LEN(@JSON+''|'')-1
	  --find the matching close-delimiter proceeding after the open-delimiter
	      SELECT
	        @NextCloseDelimiter=CHARINDEX(@NextCloseDelimiterChar, @json,
	                                      @OpenDelimiter+1)
	  --is there an intervening open-delimiter of either type
	      SELECT @NextOpenDelimiter=PATINDEX(''%[{[[]%'',
	             RIGHT(@json, @lenJSON-@OpenDelimiter)collate SQL_Latin1_General_CP850_Bin)--object
	      IF @NextOpenDelimiter=0 
	        BREAK
	      SELECT @NextOpenDelimiter=@NextOpenDelimiter+@OpenDelimiter
	      IF @NextCloseDelimiter<@NextOpenDelimiter 
	        BREAK
	      IF SUBSTRING(@json, @NextOpenDelimiter, 1)=''{'' 
	        SELECT @NextCloseDelimiterChar=''}'', @type=''object''
	      ELSE 
	        SELECT @NextCloseDelimiterChar='']'', @type=''array''
	      SELECT @OpenDelimiter=@NextOpenDelimiter
	    END
	  ---and parse out the list or name/value pairs
	  SELECT
	    @contents=SUBSTRING(@json, @OpenDelimiter+1,
	                        @NextCloseDelimiter-@OpenDelimiter-1)
	  SELECT
	    @JSON=STUFF(@json, @OpenDelimiter,
	                @NextCloseDelimiter-@OpenDelimiter+1,
	                ''@''+@type+CONVERT(NVARCHAR(5), @parent_ID))
	  WHILE (PATINDEX(''%[A-Za-z0-9@+.e]%'', @contents collate SQL_Latin1_General_CP850_Bin))<>0 
	    BEGIN
	      IF @Type=''Object'' --it will be a 0-n list containing a string followed by a string, number,boolean, or null
	        BEGIN
	          SELECT
	            @SequenceNo=0,@end=CHARINDEX('':'', '' ''+@contents)--if there is anything, it will be a string-based name.
	          SELECT  @start=PATINDEX(''%[^A-Za-z@][@]%'', '' ''+@contents collate SQL_Latin1_General_CP850_Bin)--AAAAAAAA
	          SELECT @token=SUBSTRING('' ''+@contents, @start+1, @End-@Start-1),
	            @endofname=PATINDEX(''%[0-9]%'', @token collate SQL_Latin1_General_CP850_Bin),
	            @param=RIGHT(@token, LEN(@token)-@endofname+1)
	          SELECT
	            @token=LEFT(@token, @endofname-1),
	            @Contents=RIGHT('' ''+@contents, LEN('' ''+@contents+''|'')-@end-1)
	          SELECT  @name=stringvalue FROM @strings
	            WHERE string_id=@param --fetch the name
	        END
	      ELSE 
	        SELECT @Name=null,@SequenceNo=@SequenceNo+1 
	      SELECT
	        @end=CHARINDEX('','', @contents)-- a string-token, object-token, list-token, number,boolean, or null
	      IF @end=0 
	        SELECT  @end=PATINDEX(''%[A-Za-z0-9@+.e][^A-Za-z0-9@+.e]%'', @Contents+'' '' collate SQL_Latin1_General_CP850_Bin)
	          +1
	       SELECT
	        @start=PATINDEX(''%[^A-Za-z0-9@+.e][A-Za-z0-9@+.e]%'', '' ''+@contents collate SQL_Latin1_General_CP850_Bin)
	      --select @start,@end, LEN(@contents+''|''), @contents  
	      SELECT
	        @Value=RTRIM(SUBSTRING(@contents, @start, @End-@Start)),
	        @Contents=RIGHT(@contents+'' '', LEN(@contents+''|'')-@end)
	      IF SUBSTRING(@value, 1, 7)=''@object'' 
	        INSERT INTO @hierarchy
	          (NAME, SequenceNo, parent_ID, StringValue, Object_ID, ValueType)
	          SELECT @name, @SequenceNo, @parent_ID, SUBSTRING(@value, 8, 5),
	            SUBSTRING(@value, 8, 5), ''object'' 
	      ELSE 
	        IF SUBSTRING(@value, 1, 6)=''@array'' 
	          INSERT INTO @hierarchy
	            (NAME, SequenceNo, parent_ID, StringValue, Object_ID, ValueType)
	            SELECT @name, @SequenceNo, @parent_ID, SUBSTRING(@value, 7, 5),
	              SUBSTRING(@value, 7, 5), ''array'' 
	        ELSE 
	          IF SUBSTRING(@value, 1, 7)=''@string'' 
	            INSERT INTO @hierarchy
	              (NAME, SequenceNo, parent_ID, StringValue, ValueType)
	              SELECT @name, @SequenceNo, @parent_ID, stringvalue, ''string''
	              FROM @strings
	              WHERE string_id=SUBSTRING(@value, 8, 5)
	          ELSE 
	            IF @value IN (''true'', ''false'') 
	              INSERT INTO @hierarchy
	                (NAME, SequenceNo, parent_ID, StringValue, ValueType)
	                SELECT @name, @SequenceNo, @parent_ID, @value, ''boolean''
	            ELSE
	              IF @value=''null'' 
	                INSERT INTO @hierarchy
	                  (NAME, SequenceNo, parent_ID, StringValue, ValueType)
	                  SELECT @name, @SequenceNo, @parent_ID, @value, ''null''
	              ELSE
	                IF PATINDEX(''%[^0-9]%'', @value collate SQL_Latin1_General_CP850_Bin)>0 
	                  INSERT INTO @hierarchy
	                    (NAME, SequenceNo, parent_ID, StringValue, ValueType)
	                    SELECT @name, @SequenceNo, @parent_ID, @value, ''real''
	                ELSE
	                  INSERT INTO @hierarchy
	                    (NAME, SequenceNo, parent_ID, StringValue, ValueType)
	                    SELECT @name, @SequenceNo, @parent_ID, @value, ''int''
	      if @Contents='' '' Select @SequenceNo=0
	    END
	  END
	INSERT INTO @hierarchy (NAME, SequenceNo, parent_ID, StringValue, Object_ID, ValueType)
	  SELECT ''-'',1, NULL, '''', @parent_id-1, @type
	--
	   RETURN
	END
' 
END

GO
/****** Object:  View [SEC_VW_DISTINCT_USER_PERMISSION]    Script Date: 2/14/2017 9:28:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[SEC_VW_DISTINCT_USER_PERMISSION]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [SEC_VW_DISTINCT_USER_PERMISSION]
AS
SELECT  DISTINcT U.LOGIN_ID, RP.PERMISSION_ID,P.PARENT_PERMISSION_ID, P.SYSTEM_NAME, P.PERMISSION_NAME
FROM	SEC_USER U
		INNER JOIN SEC_USER_ROLE UR ON U.USER_ID = UR.USER_ID
		INNeR JOIn SEC_ROLE_PERMISSION RP ON UR.ROLE_ID = RP.ROLE_ID
		INNER JOIN SEC_PERMISSION P ON RP.PERMISSION_ID = P.PERMISSION_ID And P.IS_DELETED = 0
' 
GO
/****** Object:  View [VW_PERMISSION_HIERARCHY]    Script Date: 2/14/2017 9:28:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[VW_PERMISSION_HIERARCHY]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [VW_PERMISSION_HIERARCHY] AS
WITH WF ( Permission_id, PARENT_PERMISSION_ID, PERMISSION_NAME, SYSTEM_NAME  )
AS
(
SELECT	Permission_id, PARENT_PERMISSION_ID , P.PERMISSION_NAME, P.SYSTEM_NAME
from	SEC_PERMISSION P
WHERE   P.PARENT_PERMISSION_ID is null
UNION ALL
SELECT	P.Permission_id, P.PARENT_PERMISSION_ID, P.PERMISSION_NAME, P.SYSTEM_NAME
from	SEC_PERMISSION P
		INNER JOIN WF ON P.PARENT_PERMISSION_ID = WF.Permission_id 
)
SELECT PERMISSION_ID, PARENT_PERMISSION_ID,  PERMISSION_NAME, dbo.FN_GET_FRIENDLY_PERMISSION_NAME(SYSTEM_NAME) USER_FRIENDLY_NAME
FROM	WF

' 
GO
/****** Object:  View [VW_WORK_FLOW]    Script Date: 2/14/2017 9:28:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[VW_WORK_FLOW]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [VW_WORK_FLOW] AS
SELECT  WORK_FLOW_ACTION_ID,
		WFA.PERMISSION_ID,
		P.SYSTEM_NAME,
		SYSTEM_TYPE,
		SYSTEM_ASSEMBLY,
		VERSION,
		ACTION_ORDER,
		IS_ERROR_TOLERANT,
		EXECUTION_BEHAVIOR
FROM	WORK_FLOW_ACTION WFA
		INNER JOIN SEC_PERMISSION P ON WFA.PERMISSION_ID = P.PERMISSION_ID


' 
GO
