INSERT INTO SYS_ERROR_MAPPING(PERMISSION_ID, ERROR_CODE, DESCRIPTION, CREATED_BY, UPDATED_BY)
SELECT NULL, 0, 'Operation Executed Successfull', 'System', 'System'
UNION ALL
SELECT NULL, 1, 'System Error', 'System', 'System'
UNION ALL
SELECT NULL, 2, 'User Do Not have Permission', 'System', 'System'
UNION ALL
SELECT NULL, 3, 'Database Error', 'System', 'System'
UNION ALL
SELECT NULL, 101, 'Incorrect Password Entered', 'System', 'System'
UNION ALL
SELECT NULL, 102, 'Account Is Locked', 'System', 'System'
UNION ALL
SELECT NULL, 103, 'Password Can not Reuse', 'System', 'System'
UNION ALL
SELECT NULL, 2001, 'System Error', 'System', 'System'