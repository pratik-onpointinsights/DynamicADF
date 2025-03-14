/****** Object:  StoredProcedure [dbo].[PROC_Location]    Script Date: 08-04-2024 11:08:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PROC_Location] AS
BEGIN  
DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));  

MERGE INTO dbo.Location TGT
USING dbo.Location_Stg STG
ON (TGT.INTEGRATION_ID = STG.INTEGRATION_ID)

WHEN MATCHED THEN
UPDATE SET
	TGT.location_id = STG.location_key,
	TGT.location_state = STG.location_state,
	TGT.location_city = STG.location_city,
	TGT.Updated_On = SYSDATETIME()
	WHEN NOT MATCHED THEN
INSERT (
	location_id,
	location_state,
	location_city,
	INTEGRATION_ID,
	Updated_On
) VALUES (
	STG.location_key,
	STG.location_state,
	STG.location_city,
	STG.INTEGRATION_ID,
	SYSDATETIME()
)
OUTPUT $action INTO @SummaryOfChanges; 

SELECT   
      SUM(CASE WHEN Change='INSERT' THEN 1 ELSE 0 END) AS InsertCount  
     ,SUM(CASE WHEN Change='UPDATE' THEN 1 ELSE 0 END) AS UpdateCount  
     ,SUM(CASE WHEN Change='DELETE' THEN 1 ELSE 0 END) AS DeleteCount  
FROM @SummaryOfChanges  
  
END  ;
GO
