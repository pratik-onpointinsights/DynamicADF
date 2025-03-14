/****** Object:  StoredProcedure [dbo].[PROC_CT_ETL_TASK_FAILURES_SUMMARY]    Script Date: 08-04-2024 11:08:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



 

 

 

CREATE PROCEDURE [dbo].[PROC_CT_ETL_TASK_FAILURES_SUMMARY]    

AS BEGIN

 

DECLARE @MaxETLRunNumber INT 

 

Select @MaxETLRunNumber = MAX(ETL_Run_Number) From dbo.ETL_TASK_RUN_LOG With(Nolock)     

 

declare @body varchar(max)     

 

set @body = cast( (     

   select td = '<p>' + cast( ETL_Run_Number as varchar(30) ) + '</p></td><td><p>' + Pipeline_Name + '</p></td><td><p>' + Module_Name + '</p></td><td><p>' + cast( Task_Key as varchar(30) ) + '</p></td><td><p>' + Target_TableName + '</p></td><td><p>' + cast( Start_Timestamp as varchar(30) ) + '</p></td><td><p>' + cast( End_Timestamp as varchar(30) ) + '</p></td><td><p>' + cast( Num_Rows_Inserted as varchar(30)) + '</p></td><td><p>' + cast( Num_Rows_Updated as varchar(30) ) + '</p></td><td><p>' + cast( Num_Rows_Deleted as varchar(30) ) + '</p></td><td><p>' + Status + '</p></td><td><p>' + Error_Message + '</p></td><td><p>' + cast( Run_ID as varchar(36) ) + '</p>'

   from (     

     Select ETL_Run_Number,      

       Pipeline_Name,      

       Module_Name,      

       Task_Key,      

       Target_TableName,      

       Start_Timestamp,      

       End_Timestamp,      

       Num_Rows_Inserted,      

       Num_Rows_Updated,      

       Num_Rows_Deleted,     

       Status,     

       --Error_Message,     

                   REPLACE(Error_Message,'"','''')  AS [Error_Message],

       Run_ID     

     From dbo.ETL_TASK_RUN_LOG With(Nolock)     

     Where ETL_Run_Number = @MaxETLRunNumber AND [Status] = 'Failed'

     ) as d  order by Start_Timestamp

   for xml path( 'tr' ), type ) as varchar(max) )     

      

set @body = '

<style>

  table, th, tr, body{margin: 0;padding: 0;box-sizing: border-box;font-weight: 400;}

  table{border-collapse:collapse;}

  table td{border:1px solid #333;}

  table th{border-right:1px solid #fff;}

  th{color: #ffffff; background-color:  #24243e;font-weight: 500;letter-spacing: 1px;}

  p{margin: 10px;width: 150px;white-space: normal;overflow-wrap: break-word;}

  table tr:nth-child(odd){background-color: #eee;}

</style>

<table>

  <tr>

    <th><p>ETL Run #</p></th>

    <th><p>Pipeline Name</p></th>

    <th><p>Module Name</p></th>

    <th><p>Task Key</p></th>

    <th><p>Target Table Name</p></th>

    <th><p>Start</p></th>

    <th><p>End</p></th>

    <th><p>Rows Inserted</p></th>

    <th><p>Rows Updated</p></th>

    <th><p>Rows Deleted</p></th>

    <th><p>Status</p></th>

    <th><p>Error Message</p></th>

    <th><p>Run ID</p></th>

  </tr>' + replace( replace( @body, '&lt;', '<' ), '&gt;', '>' ) + '</table>' 

      

Select ISNULL(@body,'No Failures') AS ETLFailuresSummary  

 
END

GO
