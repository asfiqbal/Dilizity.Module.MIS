CREATE FUNCTION dbo.CSV2Table( @str varchar(4000))
RETURNS  @Result TABLE(Value BIGINT)
AS
BEGIN
 
      DECLARE @x XML 
	  select @x = cast('<A>'+ replace(@str,',','</A><A>')+ '</A>' as xml)
     
      INSERT INTO @Result            
      SELECT t.value('.', 'int') AS inVal
      FROM @x.nodes('/A') AS x(t)
      
	  RETURN
END   
GO