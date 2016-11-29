CREATE TABLE SYSTEM_TYPE
(
	TYPE_ID INT NOT NULL PRIMARY KEY,
	TYPE_NAME NVARCHAR(200) NOT NULL UNIQUE,
	DESCRIPTION NVARCHAR(200) NOT NuLL,
	[CREATED_ON] [datetime] NOT NULL DEFAULT GETDATE(),
	[CREATED_BY] [nvarchar](100) NOT NULL,
	[UPDATED_ON] [datetime] NOT NULL DEFAULT GETDATE(),
	[UPDATED_BY] [nvarchar](100) NULL
)
GO

CREATE TABLE SYSTEM_TYPE_DATA
(
	TYPE_ID INT NOT NULL REFERENCES SYSTEM_TYPE(TYPE_ID),
	TYPE_DATA_ID INT NOT NULL,
	TYPE_DATA NVARCHAR(200) NOT NULL UNIQUE,
	DESCRIPTION NVARCHAR(200) NOT NuLL,
	[CREATED_ON] [datetime] NOT NULL DEFAULT GETDATE(),
	[CREATED_BY] [nvarchar](100) NOT NULL,
	[UPDATED_ON] [datetime] NOT NULL DEFAULT GETDATE(),
	[UPDATED_BY] [nvarchar](100) NULL,
	CONSTRAINT PK_SYSTEM_TYPE_DATA PRIMARY KEY (TYPE_ID,TYPE_DATA_ID)
)
GO

CREATE TABLE SYSTEM_CONFIGURATION
(
	SYSTEM_CONFIGURATION_ID INT NOT NULL PRIMARY KEY,
	NAME NVARCHAR(200) NOT NULL UNIQUE,
	VALUE NVARCHAR(2000) NOT NULL,
	DESCRIPTION NVARCHAR(200) NOT NuLL,
	VERSION NVARCHAR(50),
	[CREATED_ON] [datetime] NOT NULL DEFAULT GETDATE(),
	[CREATED_BY] [nvarchar](100) NOT NULL,
	[UPDATED_ON] [datetime] NOT NULL DEFAULT GETDATE(),
	[UPDATED_BY] [nvarchar](100) NULL,

)
GO

CREATE TABLE WORK_FLOW_ACTION
(
	WORK_FLOW_ACTION_ID INT IDENTITY NOT NULL PRIMARY KEY,
	PERMISSION_ID INT NOT NULL REFERENCES SEC_PERMISSION(PERMISSION_ID),
	SYSTEM_TYPE NVARCHAR(2000) NOT NULL,
	SYSTEM_ASSEMBLY NVARCHAR(2000) NOT NULL,
	VERSION NVARCHAR(50),
	ACTION_ORDER INT NOT NULL,
	[CREATED_ON] [datetime] NOT NULL DEFAULT GETDATE(),
	[CREATED_BY] [nvarchar](100) NOT NULL,
	[UPDATED_ON] [datetime] NOT NULL DEFAULT GETDATE(),
	[UPDATED_BY] [nvarchar](100) NULL
)
--DROP TABLE SYSTEM_TYPE
--DROP TABLE SYSTEM_TYPE_DATA
--DROP TABLE SYSTEM_CONFIGURATION
--DROP TABLE WORK_FLOW_ACTION