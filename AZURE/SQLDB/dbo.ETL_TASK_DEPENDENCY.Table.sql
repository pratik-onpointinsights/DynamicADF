/****** Object:  Table [dbo].[ETL_TASK_DEPENDENCY]    Script Date: 08-04-2024 11:08:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ETL_TASK_DEPENDENCY](
	[Target_Table_TaskKey] [int] NOT NULL,
	[Target_Table_Name] [varchar](50) NOT NULL,
	[Dependent_Table_TaskKey] [int] NOT NULL,
	[Dependent_Table_Name] [varchar](50) NOT NULL,
	[Created_Date] [datetime] NULL,
	[Updated_Date] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ETL_TASK_DEPENDENCY] ADD  CONSTRAINT [DF_ETL_TASK_DEPENDENCY_CREATED_DATE]  DEFAULT (getdate()) FOR [Created_Date]
GO
