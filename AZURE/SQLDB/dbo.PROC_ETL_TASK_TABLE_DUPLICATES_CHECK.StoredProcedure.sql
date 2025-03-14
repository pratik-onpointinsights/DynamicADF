/****** Object:  StoredProcedure [dbo].[PROC_ETL_TASK_TABLE_DUPLICATES_CHECK]    Script Date: 08-04-2024 11:08:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PROC_ETL_TASK_TABLE_DUPLICATES_CHECK]  
(    
	@TaskPhase VARCHAR(30) , --= 'Dim_Extract',    
	@StgTable VARCHAR(50) = NULL    
)    
AS     
BEGIN
    
DECLARE @Query NVARCHAR(MAX)     
    
IF OBJECT_ID('TempDB..#StageTables') IS NOT NULL    
DROP TABLE [dbo].[#StageTables];    
    
CREATE TABLE [dbo].[#StageTables]  
(    
--Task_Key INT NOT NULL,    
TableName VARCHAR(50) NOT NULL,    
DuplicateRecordsCount INT    
);    
    
DECLARE @cursor_db CURSOR    
DECLARE @Target   VARCHAR(50);    
    
SET @cursor_db = CURSOR    
FOR SELECT Target    
    FROM dbo.ETL_task_control With(Nolock)    
 WHERE Task_Phase = @TaskPhase and ( Target = @StgTable OR @StgTable IS NULL )    
    
OPEN @cursor_db;    
    
FETCH NEXT FROM @cursor_db INTO @Target;    
    
WHILE @@FETCH_STATUS = 0    
BEGIN    
  PRINT ' Target :'+ @Target ;    
    
   SELECT @Query =     
   '    
   INSERT INTO  [dbo].[#StageTables]  
   Select TableName, ISNULL(DupCount,0) AS DuplicateRecordsCount    
   From     
   (    
    Select ''' + @Target + ''' AS TableName, INTEGRATION_ID, DATASOURCE_NUM_ID, COUNT(*) AS DupCount    
    From dbo.' + @Target + '    
    Group By INTEGRATION_ID, DATASOURCE_NUM_ID    
    Having COUNT(*)>1    
   ) Dup    
   --UNION Select ''' + @Target + ''', 0    
       
   '    
   EXEC sp_executesql @Query    
    
     FETCH NEXT FROM @cursor_db INTO @Target;    
END;    
CLOSE @cursor_db;    
DEALLOCATE @cursor_db;    

declare @body varchar(max)    
    
set @body = cast( (    
   select td = TableName + '</td><td>' + cast( DuplicateRecordsCount as varchar(30) )     
   from (    
      select TableName, DuplicateRecordsCount    
      from [dbo].[#StageTables]  
     ) as d    
   for xml path( 'tr' ), type ) as varchar(max) )    
    
set @body = '<table cellpadding=''2'' cellspacing=''2'' border=''1''>'    
          + '<tr><th>Table Name </th><th>Duplicate Count</th></tr>'    
          + replace( replace( @body, '&lt;', '<' ), '&gt;', '>' )    
          + '</table>'    
    
Select ISNULL(@body,'No Duplicates') AS output_result    
    
END;
GO
