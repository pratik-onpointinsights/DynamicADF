/****** Object:  StoredProcedure [dbo].[PROC_ETL_TASK_DEPENDENCY_STATUS_CHECK]    Script Date: 08-04-2024 11:08:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PROC_ETL_TASK_DEPENDENCY_STATUS_CHECK]  
(
	@TaskPhase VARCHAR(30), -- 'Dim_Load' , 'Fact_Load'
	@ETLRunStartTime DATETIME,    
	@ModuleName VARCHAR(50) = NULL
)    
AS     
BEGIN
	;WITH Tot AS     
	(    
		Select Target_Table_TaskKey, COUNT(*) AS TotDepCnt     
		From dbo.ETL_task_dependency  With(Nolock)     
		Where Target_Table_TaskKey IN (
			Select Task_Key 
			From dbo.ETL_task_control  With(Nolock) 
			Where Task_Phase = @TaskPhase 
				AND (Module_Name = @ModuleName OR @ModuleName = 'All') 
				
		)
		Group By Target_Table_TaskKey    
	),
	Each AS    
	(    
		Select c.Task_Key, 
			SUM( CASE WHEN cd.Last_Successful_Start_Timestamp >= @ETLRunStartTime THEN 1 ELSE 0 END ) 
			AS TotalStatusCnt    
		From dbo.ETL_task_control c  With(Nolock)    
			JOIN dbo.ETL_task_dependency d  With(Nolock) ON c.Task_Key = d.Target_Table_TaskKey
			JOIN dbo.ETL_task_control cd  With(Nolock) ON  cd.Task_Key = d.Dependent_Table_TaskKey    
		Where c.Task_Key IN (
			Select Task_Key 
			From dbo.ETL_task_control  With(Nolock) 
			Where Task_Phase = @TaskPhase 
			AND (Module_Name = @ModuleName OR @ModuleName = 'All' ) 
		)
		Group By c.Task_Key    
	)    
	Select c.*     
	From Tot JOIN Each ON Target_Table_TaskKey = Each.Task_Key    
	   JOIN dbo.ETL_task_control c With(Nolock) ON c.Task_Key = Tot.Target_Table_TaskKey    
	Where TotDepCnt = TotalStatusCnt    
END;
GO
