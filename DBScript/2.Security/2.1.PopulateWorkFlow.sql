
INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001, 'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity'),
'Dilizity.Business.Common.Managers.EmailBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',3, 1, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity'),
'Dilizity.Business.Common.Managers.SMSBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',2, 1, 4001, 'System','System'

GO

INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Login'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Login'),
'Dilizity.API.Security.Managers.AuthenticationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Login'),
'Dilizity.Business.Common.Managers.EmailBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',3, 1, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Login'),
'Dilizity.Business.Common.Managers.SMSBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',4, 1, 4001,'System','System'
GO


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Login.Generate2FAToken'),
'Dilizity.API.Security.Managers.Generate2FATokenBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Login.Generate2FAToken'),
'Dilizity.Business.Common.Managers.EmailBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',3, 1, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Login.Generate2FAToken'),
'Dilizity.Business.Common.Managers.SMSBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',4, 1, 4001,'System','System'
GO

INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Login.TwoFA'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Login.TwoFA'),
'Dilizity.API.Security.Managers.TwoFAVerificationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Login.TwoFA'),
'Dilizity.Business.Common.Managers.EmailBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',3, 1, 4001,'System','System'
GO


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.ChangePassword'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.ChangePassword'),
'Dilizity.API.Security.Managers.ChangePasswordBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.ChangePassword'),
'Dilizity.Business.Common.Managers.EmailBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',3, 1, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.ChangePassword'),
'Dilizity.Business.Common.Managers.SMSBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',4, 1, 4001,'System','System'
go

INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.FrontOffice.Report'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.FrontOffice.Report'),
'Dilizity.API.Security.Managers.ReportExecutionBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.FrontOffice.Report'),
'Dilizity.Business.Common.Managers.EmailBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',3, 1, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.FrontOffice.Report'),
'Dilizity.Business.Common.Managers.SMSBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',4,1,4001,'System','System'
go



INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Maker'),
'Dilizity.API.Security.Managers.RoleScreenManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Maker.Delete'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Maker.Delete'),
'Dilizity.API.Security.Managers.BulkDeleteMakerBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Maker.Search'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Maker.Search'),
'Dilizity.API.Security.Managers.MakerSearchBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Maker.Search'),
'Dilizity.Business.Common.Managers.EmailBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',3, 1, 4001,'System','System'
go

INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Checker'),
'Dilizity.API.Security.Managers.CheckerScreenManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Checker.Search'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Checker.Search'),
'Dilizity.API.Security.Managers.CheckerSearchBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go



INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role'),
'Dilizity.API.Security.Managers.RoleScreenManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Search'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Search'),
'Dilizity.API.Security.Managers.RoleSearchBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go



INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add'),
'Dilizity.API.Security.Managers.ActionRoleScreenManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Save'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Save'),
'Dilizity.API.Security.Managers.RoleAddUpdateBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Maker'),
'Dilizity.API.Security.Managers.ActionRoleScreenManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Maker.Save'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Maker.Save'),
'Dilizity.API.Security.Managers.MakerSaveAsDraftBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go



INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Maker.ApprovalReady'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Maker.ApprovalReady'),
'Dilizity.API.Security.Managers.MakerApprovalReadyBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go



INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Checker'),
'Dilizity.API.Security.Managers.ActionRoleScreenManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Checker.Approve'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Checker.Approve'),
'Dilizity.API.Security.Managers.RoleAddUpdateBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Checker.Approve'),
'Dilizity.API.Security.Managers.CheckerApproveBusinessManager','Dilizity.API.Security.dll','1.0.0.0',3, 0, 4001,'System','System'
go



INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Checker.Correction'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Checker.Correction'),
'Dilizity.API.Security.Managers.CheckerCorrectionBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Checker.Reject'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Add.Checker.Reject'),
'Dilizity.API.Security.Managers.CheckerRejectBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit'),
'Dilizity.API.Security.Managers.ActionRoleScreenManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
go

INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Save'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Save'),
'Dilizity.API.Security.Managers.RoleAddUpdateBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Maker'),
'Dilizity.API.Security.Managers.ActionRoleScreenManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go




INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Maker.Save'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Maker.Save'),
'Dilizity.API.Security.Managers.MakerSaveAsDraftBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go




INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Maker.ApprovalReady'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Maker.ApprovalReady'),
'Dilizity.API.Security.Managers.MakerApprovalReadyBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Checker'),
'Dilizity.API.Security.Managers.ActionRoleScreenManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Checker.Approve'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Checker.Approve'),
'Dilizity.API.Security.Managers.RoleAddUpdateBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Checker.Approve'),
'Dilizity.API.Security.Managers.CheckerApproveBusinessManager','Dilizity.API.Security.dll','1.0.0.0',3, 0, 4001,'System','System'
go



INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Checker.Correction'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Checker.Correction'),
'Dilizity.API.Security.Managers.CheckerCorrectionBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Checker.Reject'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Checker.Reject'),
'Dilizity.API.Security.Managers.CheckerRejectBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Edit.Checker.Compare'),
'Dilizity.API.Security.Managers.RoleCheckerCompareBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
go



INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete.Maker'),
'Dilizity.API.Security.Managers.ActionRoleScreenManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete.Checker'),
'Dilizity.API.Security.Managers.ActionRoleScreenManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'

go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete.Maker.Save'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete.Maker.Save'),
'Dilizity.API.Security.Managers.MakerSaveAsDraftBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete.Maker.ApprovalReady'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete.Maker.ApprovalReady'),
'Dilizity.API.Security.Managers.MakerApprovalReadyBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go

INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete.Checker.Reject'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete.Checker.Reject'),
'Dilizity.API.Security.Managers.CheckerRejectBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete.Checker.Correction'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete.Checker.Correction'),
'Dilizity.API.Security.Managers.CheckerCorrectionBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete.Checker.Approve'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete.Checker.Approve'),
'Dilizity.API.Security.Managers.DeleteRoleBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete.Checker.Approve'),
'Dilizity.API.Security.Managers.CheckerApproveBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go




INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete.Bulk'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.Role.Delete.Bulk'),
'Dilizity.API.Security.Managers.BulkDeleteRoleBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go


------------------ User

INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User'),
'Dilizity.API.Security.Managers.SearchUserScreenManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User.Search'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User.Search'),
'Dilizity.API.Security.Managers.UserSearchBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User.Add'),
'Dilizity.API.Security.Managers.ActionUserScreenManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
go

INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User.Add.Save'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User.Add.Save'),
'Dilizity.API.Security.Managers.UserAddUpdateBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User.Add.Save'),
'Dilizity.Business.Common.Managers.EmailBusinessManager','Dilizity.Business.Common.dll','1.0.0.0',3, 1, 4001,'System','System'
go

INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User.Edit'),
'Dilizity.API.Security.Managers.ActionUserScreenManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User.Edit.Save'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User.Edit.Save'),
'Dilizity.API.Security.Managers.UserAddUpdateBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User.DeleteBulk'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User.DeleteBulk'),
'Dilizity.API.Security.Managers.BulkDeleteUserBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User.ResetPasswordBulk'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User.ResetPasswordBulk'),
'Dilizity.API.Security.Managers.BulkResetPasswordBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User.ResetPasswordBulk'),
'Dilizity.API.Security.Managers.BulkResetEmailBusinessManager','Dilizity.API.Security.dll','1.0.0.0',3, 0, 4001,'System','System'
go

INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User.BlockAccountBulk'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User.BlockAccountBulk'),
'Dilizity.API.Security.Managers.BulkBlockAccountBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go

INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User.UnblockAccountBulk'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.User.UnblockAccountBulk'),
'Dilizity.API.Security.Managers.BulkUnblockAccountBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go

------------------ Password Policy

INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.PasswordPolicy'),
'Dilizity.API.Security.Managers.SearchPasswordPolicyScreenManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go

INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.PasswordPolicy.Search'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.PasswordPolicy.Search'),
'Dilizity.API.Security.Managers.PasswordPolicySearchBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go

INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.PasswordPolicy.Edit'),
'Dilizity.API.Security.Managers.ActionPasswordPolicyScreenManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
go


INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.PasswordPolicy.Add.Save'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.PasswordPolicy.Add.Save'),
'Dilizity.API.Security.Managers.PasswordPolicyAddUpdateBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go

INSERT INTO WORK_FLOW_ACTION
(
PERMISSION_ID,
SYSTEM_TYPE,
SYSTEM_ASSEMBLY,
VERSION,
ACTION_ORDER,
IS_ERROR_TOLERANT,
EXECUTION_BEHAVIOR,
CREATED_BY,
UPDATED_BY
)
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.PasswordPolicy.Edit.Save'),
'Dilizity.API.Security.Managers.PermissionValidationBusinessManager','Dilizity.API.Security.dll','1.0.0.0',1, 0, 4001,'System','System'
UNION ALL
SELECT (SELECT PERMISSION_ID FROM SEC_PERMISSION WHERE SYSTEM_NAME = 'Dilizity.Backoffice.PasswordPolicy.Edit.Save'),
'Dilizity.API.Security.Managers.PasswordPolicyAddUpdateBusinessManager','Dilizity.API.Security.dll','1.0.0.0',2, 0, 4001,'System','System'
go