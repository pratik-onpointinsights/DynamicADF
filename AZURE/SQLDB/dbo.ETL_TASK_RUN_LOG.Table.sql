/****** Object:  Table [dbo].[ETL_TASK_RUN_LOG]    Script Date: 08-04-2024 11:08:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ETL_TASK_RUN_LOG](
	[ETL_Task_Number] [int] IDENTITY(1,1) NOT NULL,
	[ETL_Run_Number] [int] NOT NULL,
	[Pipeline_Name] [varchar](255) NULL,
	[Task_Key] [int] NOT NULL,
	[Task_Name] [varchar](255) NULL,
	[Target_TableName] [varchar](255) NULL,
	[Start_Timestamp] [datetime] NULL,
	[End_Timestamp] [datetime] NULL,
	[Num_Rows_Inserted] [int] NULL,
	[Num_Rows_Updated] [int] NULL,
	[Num_Rows_Deleted] [int] NULL,
	[Status] [varchar](30) NULL,
	[Error_Message] [nvarchar](max) NULL,
	[Run_ID] [nvarchar](36) NULL,
	[Module_Name] [varchar](25) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
