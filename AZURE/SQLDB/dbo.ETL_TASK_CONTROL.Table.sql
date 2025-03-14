/****** Object:  Table [dbo].[ETL_TASK_CONTROL]    Script Date: 08-04-2024 11:08:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ETL_TASK_CONTROL](
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
	[IsPreExtractDependency] [bit] NULL,
 CONSTRAINT [PK_ETLTaskControl_Task_Key] PRIMARY KEY CLUSTERED 
(
	[Task_Key] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
