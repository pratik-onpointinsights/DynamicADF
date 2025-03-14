/****** Object:  StoredProcedure [dbo].[PROC_ETL_TASK_CONTROL_LAST_SUCC_START_TIMESTAMP_UPDATE]    Script Date: 08-04-2024 11:08:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PROC_ETL_TASK_CONTROL_LAST_SUCC_START_TIMESTAMP_UPDATE]
AS
BEGIN
;WITH Tgt AS 
(
		SELECT	DISTINCT etc.Task_Key,
						 etc.Source,
						 etc.Target, 
						 etc.Last_Successful_Start_Timestamp
		FROM	ETL_TASK_CONTROL etc JOIN ETL_TASK_DEPENDENCY etd ON etc.Target = etd.Target_Table_Name
		WHERE	Task_Phase <> 'Fact_PostLoad'
)
,Tgt1 AS
(
		SELECT	Tgt.Task_Key AS Target_TaskKey,
				value as Source,
				Tgt.Target,
				Tgt.Last_Successful_Start_Timestamp
		FROM	Tgt CROSS APPLY string_split(Tgt.Source,',')
)
,Src AS
(
		SELECT	DISTINCT etc.Task_Key AS Source_TaskKey,
						 etc.Target, 
						 etc.Last_Successful_Start_Timestamp
		FROM	ETL_TASK_CONTROL etc JOIN Tgt1 ON etc.Target = Tgt1.Source
)

		  
--Select	etls.Task_Key, 
--		etls.Target, 
--		etls.Last_Successful_Start_Timestamp, 
--		etlt.Task_Key, 
--		etlt.Target, 
--		etlt.Last_Successful_Start_Timestamp

Update	etls
Set		etls.Last_Successful_Start_Timestamp = etlt.Last_Successful_Start_Timestamp

From	Tgt1  JOIN Src ON Tgt1.Source = Src.Target
			  JOIN ETL_TASK_CONTROL etls ON Src.Source_TaskKey = etls.Task_Key
			  JOIN ETL_TASK_CONTROL etlt ON Tgt1.Target_TaskKey = etlt.Task_Key
Where   etls.Last_Successful_Start_Timestamp > etlt.Last_Successful_Start_Timestamp
END
GO
