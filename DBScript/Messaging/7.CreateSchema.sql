--DROP TABLE MSG_TEMPLATE_CODES;
--DROP TABLE MSG_TEMPLATES
--DROP TABLE MSG_ASSIGNED_TEMPLATES

CREATE TABLE MSG_TEMPLATE_CODES
(
	[TEMPLATE_CODE_ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	NAME NVARCHAR(200) NOT NULL UNIQUE,
	DESCRIPTION NVARCHAR(200) NOT NULL,
	MULTIPLE_RESULT NVARCHAR(5) NOT NULL,
	CONTEXT_AWARE NVARCHAR(5) NOT NULL,
	DATA_FUNCTION NVARCHAR(4000) NOT NULL,
	IS_DELETED  int NULL,
	IS_SYSTEM  int NULL,
	CREATED_ON DATETIME DEFAULT GETDATE(),
	CREATED_BY NVARCHAR(200),
	UPDATED_ON DATETIME DEFAULT GETDATE(),
	UPDATED_BY NVARCHAR(200)
)
GO

CREATE TABLE MSG_TEMPLATES
(
	[TEMPLATE_ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	NAME NVARCHAR(200) NOT NULL UNIQUE,
	DESCRIPTION NVARCHAR(200) NOT NULL,
	TEMPLATE_TYPE INT NOT NULL,
	TEMPLATE  NVARCHAR(MAX) NOT NULL,
	SUBJECT NVARCHAR(1000) NULL,
	IS_DELETED  int NULL,
	IS_SYSTEM  int NULL,
	CREATED_ON DATETIME DEFAULT GETDATE(),
	CREATED_BY NVARCHAR(200),
	UPDATED_ON DATETIME DEFAULT GETDATE(),
	UPDATED_BY NVARCHAR(200)
)
GO

CREATE TABLE MSG_ASSIGNED_TEMPLATES
(
	[ASSIGNED_TEMPLATE_ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	PERMISSION_ID INT NOT NULL REFERENCES SEC_PERMISSION(PERMISSION_ID),
	TEMPLATE_ID INT NOT NULL REFERENCES MSG_TEMPLATES(TEMPLATE_ID),
	IS_SYSTEM  int NULL,
	CREATED_ON DATETIME DEFAULT GETDATE(),
	CREATED_BY NVARCHAR(200),
	UPDATED_ON DATETIME DEFAULT GETDATE(),
	UPDATED_BY NVARCHAR(200)
)
GO

CREATE TABLE MSG_NOTIFICATIONS
(
	[NOTIFICATION_ID]	[int] IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	OPERATION_ID		INT NOT NULL REFERENCES OF_OPERATIONS(OPERATION_ID),
	NOTIFICATION_TYPE	NVARCHAR(10) NOT NULL,
	[FROM]				NVARCHAR(200) NOT NULL,
	[TO]				NVARCHAR(200) NOT NULL,
	CC					NVARCHAR(200) NULL,
	SUBJECT				NVARCHAR(200) NOT NULL,
	BODY				NVARCHAR(MAX) NOT NULL,
	STATUS				NVARCHAR(10)  NOT NULL,
	CREATED_ON			DATETIME DEFAULT GETDATE(),
	CREATED_BY			NVARCHAR(200),
	UPDATED_ON			DATETIME DEFAULT GETDATE(),
	UPDATED_BY			NVARCHAR(200)
)
GO

