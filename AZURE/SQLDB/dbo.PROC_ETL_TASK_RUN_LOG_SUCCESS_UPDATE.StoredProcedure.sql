/****** Object:  StoredProcedure [dbo].[PROC_ETL_TASK_RUN_LOG_SUCCESS_UPDATE]    Script Date: 08-04-2024 11:08:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PROC_ETL_TASK_RUN_LOG_SUCCESS_UPDATE]  
(    
	@PipelineName VARCHAR(250),
	@ETLRunNumber INT,
	@TaskKey INT,
	@TaskName VARCHAR(255),
	@TaskStartTimeStamp NVARCHAR(40),
	@NoOfRowsInserted INT,
	@NoOfRowsUpdated INT,
	@NoOfRowsDelete INT,
	@Status VARCHAR(30),
	@TargetTableName VARCHAR(255),
	@RunID NVARCHAR(36),
	@ModuleName VARCHAR(25)
)    
AS
BEGIN
	INSERT INTO dbo.ETL_Task_run_log   
	(    
		Pipeline_Name,
		ETL_Run_Number,
		Task_Key,
		Task_Name,
		Target_TableName,
		Start_Timestamp,
		End_Timestamp,
		Num_Rows_Inserted,
		Num_Rows_Updated,
		Num_Rows_Deleted,
		Status,
		Error_Message,
		Run_ID,
		Module_Name
	) VALUES (    
		@PipelineName,
		@ETLRunNumber,
		@TaskKey,
		@TaskName,
		@TargetTableName,
		@TaskStartTimeStamp,
		DATEADD(MI, -360,GETDATE()),
		ISNULL(@NoOfRowsInserted,0),
		ISNULL(@NoOfRowsUpdated,0),
		ISNULL(@NoOfRowsDelete,0),
		@Status,
		'',
		@RunID,
		@ModuleName    
	)
END;
GO
