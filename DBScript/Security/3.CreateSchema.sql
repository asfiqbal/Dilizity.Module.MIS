CREATE TABLE [SEC_PASSWORD_POLICY](
	[PASSWORD_POLICY_ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED ,
	[POLICY_NAME] [nvarchar](100) NOT NULL,
	[LENGTH_RULE] [int] NULL,
	[EXPIRY_RULE] [int] NULL,
	[NUMBER_CANT_REUSE] [int] NULL,
	[COMPLEXITY_RULE] [int] NULL,
	[FIRST_LOGIN_CHANGE_PASSWORD] [int] NULL,
	[DEFAULT_PASSWORD_ATTEMPTS] [int] NULL,
	[ACCOUNT_LOCK_ON_FAILED_ATTEMPTS] [int] NULL,
	[IS_SYSTEM] [int] NULL,
	[IS_DELETED] [int] NULL,
	[IS_EMAIL_SENT_ON_LOGON] [int] NULL,
	[IS_SMS_SENT_ON_LOGON] [int] NULL,
	[IS_2FA_ENABLED] [int] NULL,
	[IS_CAPTCHA_ENABLED] [int] NULL,
	[CREATED_ON] [datetime] NOT NULL DEFAULT GETDATE(),
	[CREATED_BY] [nvarchar](100) NOT NULL,
	[UPDATED_ON] [datetime] NOT NULL DEFAULT GETDATE(),
	[UPDATED_BY] [nvarchar](100) NULL,
)
GO

CREATE TABLE [SEC_ROLE](
	[ROLE_ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	[ROLE_NAME] [nvarchar](100) NOT NULL,
	[IS_SYSTEM] [int] NULL,
	[IS_DELETED] [int] NULL,
	[CREATED_ON] [datetime] NOT NULL DEFAULT GETDATE(),
	[CREATED_BY] [nvarchar](100) NOT NULL,
	[UPDATED_ON] [datetime] NOT NULL DEFAULT GETDATE(),
	[UPDATED_BY] [nvarchar](100) NULL,
)
GO

CREATE TABLE [SEC_USER](
	[USER_ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	[NAME] [nvarchar](200) NOT NULL,
	[LOGIN_ID] [nvarchar](100) NOT NULL UNIQUE,
	[PASSWORD] [nvarchar](100) NOT NULL,
	[PASSWORD_POLICY_ID] [int] NOT NULL REFERENCES SEC_PASSWORD_POLICY(PASSWORD_POLICY_ID),
	[PASSWORD_ATTEMPTS] [int] NULL,
	[ACCOUNT_LOCKED] [int] NULL,
	[CHANGE_PASSWORD_ON_LOGON] [int] NULL,
	[EMAIL] [nvarchar](200) NULL,
	[MOBILE_NUMBER] [nvarchar](20) NULL,
	[LAST_PASSWORD_CHANGE_DATETIME] [datetime] NULL,
	[LAST_LOGIN_DATETIME] [datetime] NULL,
	[IS_SYSTEM] [int] NULL,
	[IS_DELETED] [int] NULL,
	[CREATED_ON] [datetime] NOT NULL DEFAULT GETDATE(),
	[CREATED_BY] [nvarchar](100) NOT NULL,
	[UPDATED_ON] [datetime] NOT NULL DEFAULT GETDATE(),
	[UPDATED_BY] [nvarchar](100) NULL,
)
GO

/****** Object:  Table [SEC_USER_ROLE]    Script Date: 07/25/2016 00:59:07 ******/
CREATE TABLE [SEC_USER_ROLE](
	[USER_ROLE_ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	[USER_ID] [int] NOT NULL REFERENCES SEC_USER(USER_ID),
	[ROLE_ID] [int] NOT NULL REFERENCES SEC_ROLE(ROLE_ID),
	[CREATED_ON] [datetime] NOT NULL DEFAULT GETDATE(),
	[CREATED_BY] [nvarchar](100) NOT NULL,
	[UPDATED_ON] [datetime] NOT NULL DEFAULT GETDATE(),
	[UPDATED_BY] [nvarchar](100) NULL,
)
GO

CREATE TABLE [SEC_PERMISSION](
	[PERMISSION_ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED ,
	[PARENT_PERMISSION_ID] [int] NULL REFERENCES [SEC_PERMISSION]([PERMISSION_ID]),
	[PERMISSION_NAME] [nvarchar](100) NOT NULL,
	[CAN_ADD] [int] NULL,
	[CAN_UPDATE] [int] NULL,
	[CAN_DELETE] [int] NULL,
	[CAN_VIEW] [int] NULL,
	[CAN_MAKE] [int] NULL,
	[CAN_CHECK] [int] NULL,
	[CAN_EXECUTE] [int] NULL,
	[IS_SYSTEM] [int] NULL,
	[IS_DELETED] [int] NULL,
	[CREATED_ON] [datetime] NOT NULL DEFAULT GETDATE(),
	[CREATED_BY] [nvarchar](100) NOT NULL,
	[UPDATED_ON] [datetime] NOT NULL DEFAULT GETDATE(),
	[UPDATED_BY] [nvarchar](100) NULL,

)
GO

CREATE TABLE [SEC_ROLE_PERMISSION](
	[ROLE_PERMISSION_ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	[ROLE_ID] [int] NOT NULL REFERENCES SEC_ROLE(ROLE_ID),
	[PERMISSION_ID] [int] NOT NULL REFERENCES SEC_PERMISSION(PERMISSION_ID),
	[CREATED_ON] [datetime] NOT NULL DEFAULT GETDATE(),
	[CREATED_BY] [nvarchar](100) NOT NULL,
	[UPDATED_ON] [datetime] NOT NULL DEFAULT GETDATE(),
	[UPDATED_BY] [nvarchar](100) NULL,

)
GO

CREATE TABLE SEC_CHANGE_PASSWORD_HISTORY
(
	[CHANGE_PASSWORD_HISTORY_ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	USER_ID INT NOT NULL REFERENCES SEC_USER(USER_ID),
	PASSWORD NVARCHAR(200) NOT NULL,
	CREATED_ON DATETIME DEFAULT GETDATE(),
	CREATED_BY NVARCHAR(200)
)
GO

CREATE TABLE [SEC_AUDIT]
(
	[AUDIT_ID] [int] IDENTITY(1,1) NOT NULL,
	[USER_ID] [int] NOT NULL REFERENCES SEC_USER(USER_ID),
	[PERMISSION_ID] [int] NOT NULL REFERENCES SEC_PERMISSION(PERMISSION_ID),
    [IS_SUCCESS] nvarchar(200) NOT NULL,
	[DATA] NVARCHAR(MAX) NULL,
	[CREATED_ON] [datetime] NOT NULL DEFAULT GETDATE(),
	[CREATED_BY] [nvarchar](100) NOT NULL,

)
GO

--DROP TABLE WORK_FLOW_ACTION
CREATE TABLE WORK_FLOW_ACTION
(
	WORK_FLOW_ACTION_ID INT IDENTITY NOT NULL PRIMARY KEY,
	PERMISSION_ID INT NOT NULL REFERENCES SEC_PERMISSION(PERMISSION_ID),
	SYSTEM_TYPE NVARCHAR(2000) NOT NULL,
	SYSTEM_ASSEMBLY NVARCHAR(2000) NOT NULL,
	VERSION NVARCHAR(50),
	ACTION_ORDER INT NOT NULL,
	IS_ERROR_TOLERANT INT NULL,
	EXECUTION_BEHAVIOR INT NOT NULL,
	[CREATED_ON] [datetime] NOT NULL DEFAULT GETDATE(),
	[CREATED_BY] [nvarchar](100) NOT NULL,
	[UPDATED_ON] [datetime] NOT NULL DEFAULT GETDATE(),
	[UPDATED_BY] [nvarchar](100) NULL
)
GO

CREATE VIEW SEC_VW_DISTINCT_USER_PERMISSION
AS
SELECT  DISTINcT U.LOGIN_ID, RP.PERMISSION_ID, P.PERMISSION_NAME
FROM	SEC_USER U
		INNER JOIN SEC_USER_ROLE UR ON U.USER_ID = UR.USER_ID
		INNeR JOIn SEC_ROLE_PERMISSION RP ON UR.ROLE_ID = RP.ROLE_ID
		INNER JOIN SEC_PERMISSION P ON RP.PERMISSION_ID = P.PERMISSION_ID And P.IS_DELETED = 0
GO


--DROP VIEW SEC_VW_DISTINCT_USER_PERMISSION