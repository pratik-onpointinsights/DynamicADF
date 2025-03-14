/****** Object:  StoredProcedure [dbo].[PROC_ETL_TASK_CONTROL_UPDATE]    Script Date: 08-04-2024 11:08:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PROC_ETL_TASK_CONTROL_UPDATE]
(  
@TaskStartTimeStamp NVARCHAR(40),  
@TargetTableName VARCHAR(255)  
)  
AS  
BEGIN  
 UPDATE dbo.ETL_task_control
 SET  Last_Successful_Start_Timestamp = @TaskStartTimeStamp  
 WHERE [Target] = @TargetTableName  
END
GO
