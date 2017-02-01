INSERT INTO [dbo].[RPT_REPORT_MENU] (
		PARENT_ID,
		DISPLAY_NAME,
		URL,
		PERMISSION_ID,
		IS_SYSTEM,
		IS_DELETED,
		CREATED_BY,
		UPDATED_BY
) 
SELECT NULL, N'Administration', '', (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.FrontOffice.Report.Administration'),0, 0, N'System', N'System'
GO

INSERT INTO [dbo].[RPT_REPORT_MENU] (
		PARENT_ID,
		PERMISSION_ID,
		DISPLAY_NAME,
		URL,
		IS_SYSTEM,
		IS_DELETED,
		CREATED_BY,
		UPDATED_BY
) 
SELECT (SELECT REPORT_MENU_ID FROM [RPT_REPORT_MENU] WHERE DISPLAY_NAME = 'Administration'),(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE PERMISSION_NAME = 'Dilizity.FrontOffice.Report.Administration.Audit'),  N'Audit Report', 'Dilizity.Report', 0, 0, N'System', N'System'
GO

INSERT INTO RPT_REPORT_DATA_SOURCE
(
	DATA_SOURCE_NAME,
	CONNECTION_STRING,
	PROVIDER_NAME,
	IS_SYSTEM,
	IS_DELETED,
	[CREATED_BY],
	[UPDATED_BY]
)
SELECT 'REPORT_MIS_DATA_SOURCE',
		'5lyXvz6GFZNu5UlYMITJob2pqmVG0y9IqtLrver3KEmwpZPgGkayiyiRMJrapPXHa3M6BNj0jgNDqkBINjWiBG24ujWyBb6/JDeWRlgbM+gghB7oq65OZQ==',
		'System.Data.SqlClient',
		1,
		0,
		'System',
		'System'

GO
--DELETE FROM RPT_REPORT_COLUMNS;
--DELETE FROM RPT_REPORT_FILTERS;
--DELETE FROM RPT_REPORT;

INSERT INTO RPT_REPORT
(
	SYSTEM_NAME,
	DISPLAY_NAME,
	REPORT_DATA_SOURCE_ID,
	QUERY,
	REPORT_PERMISSION_ID,
	IS_SYSTEM,
	IS_DELETED,
	[CREATED_BY],
	[UPDATED_BY]
)
SELECT 'Dilizity.Report.Admin.Audit',
		'Audit Report',
		(SELECT REPORT_DATA_SOURCE_ID FROM RPT_REPORT_DATA_SOURCE WHERE DATA_SOURCE_NAME = 'REPORT_MIS_DATA_SOURCE'),
		'SELECT U.USER_ID, U.NAME, P.PERMISSION_NAME, IS_SUCCESS, DATA, A.CREATED_ON
         FROM   SEC_AUDIT A
				INNER JOIN SEC_USER U ON A.USER_ID = U.USER_ID
				INNER JOIN SEC_PERMISSION P ON A.PERMISSION_ID = P.PERMISSION_ID
         WHERE	(U.USER_ID = @USER_ID OR @USER_ID = -1)
         AND	(A.PERMISSION_ID = @PERMISSION_ID OR @PERMISSION_ID = -1)
         AND	A.CREATED_ON BETWEEN @FROM_DATE AND @TO_DATE',
		(SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.FrontOffice.Report.Administration.Audit'),
		1,
		0,
		'System',
		'System'
GO

INSERT INTO RPT_REPORT_FILTERS
(  
	REPORT_ID,
	FILTER_NAME,
	DISPLAY_NAME,
	PLACE_HOLDER,
	TEMPLATE_OPTION_TYPE,
	REPORT_DATA_SOURCE_ID,
	FILTER_TYPE_ID,
	FILTER_DATA_TYPE_ID,
	FILTER_DATA_SOURCE_QUERY,
	IS_MANDATORY,
	IS_SYSTEM,
	IS_DELETED,
	[CREATED_BY],
	[UPDATED_BY]
)
SELECT  (SELECT REPORT_ID FROM RPT_REPORT WHERE SYSTEM_NAME = 'Dilizity.Report.Admin.Audit'),
		'USER_ID',
		'User Name', 
		'Enter User Id',
		NULL,
		(SELECT REPORT_DATA_SOURCE_ID FROM RPT_REPORT_DATA_SOURCE WHERE DATA_SOURCE_NAME = 'REPORT_MIS_DATA_SOURCE'),
		(SELECT TYPE_DATA_ID FROM SYSTEM_TYPE_DATA WHERE TYPE_DATA = 'select'), 
		(SELECT TYPE_DATA_ID FROM SYSTEM_TYPE_DATA WHERE TYPE_DATA = 'System.Int32'),
		'SELECT USER_ID Id, NAME Value from SEC_USER WHERE IS_DELETED = 0',
		1,
		1,
		0,
		'System',
		'System'
UNION ALL
SELECT  (SELECT REPORT_ID FROM RPT_REPORT WHERE SYSTEM_NAME = 'Dilizity.Report.Admin.Audit'),
		'PERMISSION_ID',
		'Permission Name', 
		'Enter Permission Name',
		NULL,
		(SELECT REPORT_DATA_SOURCE_ID FROM RPT_REPORT_DATA_SOURCE WHERE DATA_SOURCE_NAME = 'REPORT_MIS_DATA_SOURCE'),
		(SELECT TYPE_DATA_ID FROM SYSTEM_TYPE_DATA WHERE TYPE_DATA = 'select'), 
		(SELECT TYPE_DATA_ID FROM SYSTEM_TYPE_DATA WHERE TYPE_DATA = 'System.Int32'),
		'SELECT PERMISSION_ID Id, SYSTEM_NAME Value from SEC_PERMISSION WHERE IS_DELETED = 0',
		1,
		1,
		0,
		'System',
		'System'
UNION ALL
SELECT  (SELECT REPORT_ID FROM RPT_REPORT WHERE SYSTEM_NAME = 'Dilizity.Report.Admin.Audit'),
		'FROM_DATE',
		'From Date', 
		'Enter From Date',
		(SELECT TYPE_DATA_ID FROM SYSTEM_TYPE_DATA WHERE TYPE_DATA = 'text'),
		NULL,
		(SELECT TYPE_DATA_ID FROM SYSTEM_TYPE_DATA WHERE TYPE_DATA = 'datepicker'), 
		(SELECT TYPE_DATA_ID FROM SYSTEM_TYPE_DATA WHERE TYPE_DATA = 'System.DateTime'),
		NULL,
		1,
		1,
		0,
		'System',
		'System'
UNION ALL
SELECT  (SELECT REPORT_ID FROM RPT_REPORT WHERE SYSTEM_NAME = 'Dilizity.Report.Admin.Audit'),
		'TO_DATE',
		'To Date', 
		'Enter To Date',
		(SELECT TYPE_DATA_ID FROM SYSTEM_TYPE_DATA WHERE TYPE_DATA = 'text'),
		NULL,
		(SELECT TYPE_DATA_ID FROM SYSTEM_TYPE_DATA WHERE TYPE_DATA = 'datepicker'), 
		(SELECT TYPE_DATA_ID FROM SYSTEM_TYPE_DATA WHERE TYPE_DATA = 'System.DateTime'),
		NULL,
		1,
		1,
		0,
		'System',
		'System'
GO

INSERT INTO RPT_REPORT_COLUMNS
(  
	REPORT_ID,
	COLUMN_NAME,
	DISPLAY_NAME,
	MASKING_FILTER_ID,
	COLUMN_PERMISSION_NAME,
	IS_SYSTEM,
	IS_DELETED,
	[CREATED_BY],
	[UPDATED_BY]
)
SELECT (SELECT REPORT_ID FROM RPT_REPORT WHERE SYSTEM_NAME = 'Dilizity.Report.Admin.Audit'),
		'USER_ID',
		'User Id',
		NULL,
		NULL,
		0,
		0,
		'System',
		'System'
UNION ALL
SELECT (SELECT REPORT_ID FROM RPT_REPORT WHERE SYSTEM_NAME = 'Dilizity.Report.Admin.Audit'),
		'NAME',
		'Name',
		NULL,
		NULL,
		0,
		0,
		'System',
		'System'
UNION ALL
SELECT  (SELECT REPORT_ID FROM RPT_REPORT WHERE SYSTEM_NAME = 'Dilizity.Report.Admin.Audit'),
		'PERMISSION_NAME',
		'Permission Name',
		NULL,
		NULL,
		0,
		0,
		'System',
		'System'
UNION ALL
SELECT (SELECT REPORT_ID FROM RPT_REPORT WHERE SYSTEM_NAME = 'Dilizity.Report.Admin.Audit'),
		'IS_SUCCESS',
		'Is Success',
		NULL,
		NULL,
		0,
		0,
		'System',
		'System'
UNION ALL
SELECT (SELECT REPORT_ID FROM RPT_REPORT WHERE SYSTEM_NAME = 'Dilizity.Report.Admin.Audit'),
		'DATA',
		'Data',
		NULL,
		NULL,
		0,
		0,
		'System',
		'System'
UNION ALL
SELECT (SELECT REPORT_ID FROM RPT_REPORT WHERE SYSTEM_NAME = 'Dilizity.Report.Admin.Audit'),
		'CREATED_ON',
		'Created On',
		NULL,
		NULL,
		0,
		0,
		'System',
		'System'
GO

INSERT INTO RPT_REPORT_SYSTEM_FIELDS
(  
	FIELD_NAME,
	DISPLAY_NAME,
	PLACE_HOLDER,
	TEMPLATE_OPTION_TYPE,
	FILTER_TYPE_ID,
	IS_DELETED,
	[CREATED_BY],
	[UPDATED_BY]
)
SELECT  'ReportId',
		NULL,
		NULL,
		(SELECT TYPE_DATA_ID FROM SYSTEM_TYPE_DATA WHERE TYPE_DATA = 'hidden'),
		(SELECT TYPE_DATA_ID FROM SYSTEM_TYPE_DATA WHERE TYPE_DATA = 'input'),
		0,
		'System',
		'System'
GO
