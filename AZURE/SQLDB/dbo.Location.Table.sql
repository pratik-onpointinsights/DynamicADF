/****** Object:  Table [dbo].[Location]    Script Date: 08-04-2024 11:08:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Location](
	[location_key] [int] IDENTITY(1,1) NOT NULL,
	[location_id] [int] NULL,
	[location_state] [varchar](50) NULL,
	[location_city] [varchar](50) NULL,
	[Inserted_On] [datetime] NULL,
	[Updated_On] [datetime] NULL,
	[integration_id] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Location] ADD  CONSTRAINT [DF_Location_Inserted_On]  DEFAULT (getdate()) FOR [Inserted_On]
GO
