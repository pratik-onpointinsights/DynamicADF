/****** Object:  Table [dbo].[ETL_Task_Control_Bckup]    Script Date: 08-04-2024 11:08:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ETL_Task_Control_Bckup](
	[Task_Key] [int] IDENTITY(1,1) NOT NULL,
	[Task_Name] [varchar](255) NULL,
	[Task_Phase] [varchar](30) NULL,
	[Module_Name] [varchar](50) NULL,
	[Source] [varchar](250) NULL,
	[Target] [varchar](50) NULL,
	[Last_Successful_Start_Timestamp] [datetime] NULL,
	[SQL_Text] [nvarchar](max) NULL,
	[Procedure_Name] [varchar](max) NULL,
	[IsRunnable] [tinyint] NULL,
	[IsPreExtractDependency] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
