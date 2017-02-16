WHILE EXISTS(select NULL from sys.databases where name='ReportMIS')
BEGIN
    DECLARE @SQL varchar(max)
    SELECT @SQL = COALESCE(@SQL,'') + 'Kill ' + Convert(varchar, SPId) + ';'
    FROM MASTER..SysProcesses
    WHERE DBId = DB_ID(N'ReportMIS') AND SPId <> @@SPId
    EXEC(@SQL)
    DROP DATABASE ReportMIS
END
GO

CREATE DATABASE ReportMIS
GO
