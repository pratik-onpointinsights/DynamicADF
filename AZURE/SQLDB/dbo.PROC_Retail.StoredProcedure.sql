/****** Object:  StoredProcedure [dbo].[PROC_Retail]    Script Date: 08-04-2024 11:08:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[PROC_Retail] AS    
BEGIN    
DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));    
MERGE INTO [dbo].[Retail] F
USING   
   (  
      SELECT  
		 isnull(Loc.Location_Key, 0) AS Location_Key, 
         FS.transaction_date AS transaction_date,  
         FS.transaction_hour AS transaction_hour,  
         FS.location_id AS location_id,  
         FS.location_state AS location_state,  
         FS.location_city AS location_city,  
         FS.rewards_number AS rewards_number,  
		 FS.rewards_member AS rewards_member,
         FS.num_of_items AS num_of_items,  
         FS.coupon_flag AS coupon_flag,  
         FS.discount_amt AS discount_amt,  
         FS.order_amt AS order_amt,  
		 FS.integration_id AS integration_id,
         sysdatetime() AS Updated_On   
      FROM  
      [dbo].[Retail_Stg] FS  
	  
	  LEFT OUTER JOIN DBO.Location Loc
      ON ( convert(varchar, Loc.location_id) = convert(varchar, FS.location_id))
) F1
ON (F.INTEGRATION_ID = F1.INTEGRATION_ID)  
  
WHEN MATCHED THEN   
UPDATE SET  
   F.location_key = f1.location_key,
   F.transaction_date = F1.transaction_date,
   F.location_id = F1.location_id,
   F.location_state = F1.location_state,
   F.location_city = F1.location_city,
   F.rewards_number = F1.rewards_number,
   F.rewards_member = F1.rewards_member,
   F.num_of_items = F1.num_of_items,
   F.coupon_flag = F1.coupon_flag,
   F.discount_amt = F1.discount_amt,
   F.order_amt = F1.order_amt,
   F.updated_on = sysdatetime()
  
WHEN NOT MATCHED THEN  
INSERT (  
	location_key,
	transaction_date,
	transaction_hour,
	location_id,
	location_state,
	location_city,
	rewards_number,
	rewards_member,
	num_of_items,
	coupon_flag,
	discount_amt,
	order_amt,
	integration_id,
	Inserted_on,
	Updated_on)
VALUES (
F1.location_key,
F1.transaction_date,
F1.transaction_hour,
F1.location_id,
F1.location_state,
F1.location_city,
F1.rewards_number,
F1.rewards_member,
F1.num_of_items,
F1.coupon_flag,
F1.discount_amt,
F1.order_amt,
F1.integration_id,
sysdatetime(),  
sysdatetime()
) OUTPUT $action INTO @SummaryOfChanges;    
    
SELECT     
      SUM(CASE WHEN Change='INSERT' THEN 1 ELSE 0 END) AS InsertCount    
     ,SUM(CASE WHEN Change='UPDATE' THEN 1 ELSE 0 END) AS UpdateCount    
     ,SUM(CASE WHEN Change='DELETE' THEN 1 ELSE 0 END) AS DeleteCount    
FROM @SummaryOfChanges    
    
END;
GO
