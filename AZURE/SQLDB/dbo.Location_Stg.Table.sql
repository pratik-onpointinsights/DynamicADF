/****** Object:  Table [dbo].[Location_Stg]    Script Date: 08-04-2024 11:08:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Location_Stg](
	[location_key] [int] IDENTITY(1,1) NOT NULL,
	[location_id] [int] NULL,
	[location_state] [varchar](50) NULL,
	[location_city] [varchar](50) NULL,
	[Inserted_On] [datetime] NULL,
	[Is_Active] [bit] NULL,
	[Updated_On] [datetime] NULL,
	[integration_id] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Location_Stg] ADD  CONSTRAINT [DF_Location_Stg_inserted_at]  DEFAULT (getdate()) FOR [Inserted_On]
GO
ALTER TABLE [dbo].[Location_Stg] ADD  CONSTRAINT [DF_Location_Stg_is_active]  DEFAULT ((1)) FOR [Is_Active]
GO
