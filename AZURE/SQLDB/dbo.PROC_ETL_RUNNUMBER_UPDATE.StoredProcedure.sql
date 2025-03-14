/****** Object:  StoredProcedure [dbo].[PROC_ETL_RUNNUMBER_UPDATE]    Script Date: 08-04-2024 11:08:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PROC_ETL_RUNNUMBER_UPDATE]
(  
@ETLRunStartTime NVARCHAR(23)   
)  
AS  
BEGIN  
  
DECLARE @MaxETLRunNumber INT  
  
SELECT @MaxETLRunNumber = MAX(ISNULL([ETL_Run_Number],0))+1  
FROM [dbo].[ETL_Task_run_log]  
--WHERE [Status] = 'Succeeded'  
  
UPDATE [dbo].[ETL_Task_run_log]  
SET  [ETL_Run_Number] =  @MaxETLRunNumber  
WHERE [Start_TimeStamp] >= @ETLRunStartTime --AND [Status] = 'Succeeded'  
  
END
GO
